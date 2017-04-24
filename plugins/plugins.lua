do

  -- Returns the key (index) in the config.enabled_plugins table
  local function plugin_enabled(name)
    for k,v in pairs(_config.enabled_plugins) do
      if name == v then
        return k
      end
    end
    -- If not found
    return false
  end

  -- Returns true if file exists in plugins folder
  local function plugin_exists(name)
    for k,v in pairs(plugins_names()) do
      if name .. '.lua' == v then
        return true
      end
    end
    return false
  end

  local function list_plugins(only_enabled, msg)
    local text = ''
    local psum = 0
    for k, v in pairs(plugins_names()) do
      --  🔵 enabled, 🔴 disabled
      local status = '🔴'
      psum = psum+1
      pact = 0
      -- Check if is enabled
      for k2, v2 in pairs(_config.enabled_plugins) do
        if v == v2 .. '.lua' then
          status = '🔵'
        end
        pact = pact+1
      end
      if not only_enabled or status == '🔵' then
        -- get the name
        v = v:match('(.*)%.lua')
        text = text .. status .. '  *' .. v .. '*\n'
      end
    end
    local text = text .. '\n' .. psum .. '  plugins installed.\n'
        .. '🔵  ' .. pact .. ' enabled.\n❌  ' .. psum-pact .. ' disabled.'
    reply_msg(msg.id, text, ok_cb, true)
  end
  
 function enable_all()
    local psum = 0
    for k, v in pairs(plugins_names()) do
      local status = false
      for k2, v2 in pairs(_config.enabled_plugins) do
        if v == v2 .. '.lua' then
          status = true
        end
      end
      if status == false then
        v = v:match('(.*)%.lua')
        table.insert(_config.enabled_plugins, v)
            print(v .. ' added to _config table')
      end
    end
    save_config()
	return reload_plugins(false, msg)

  end

  local function reload_plugins(only_enabled, msg)
    plugins = {}
    load_plugins()
    return list_plugins(true, msg)
  end

function splugin(msg)
local uid = msg.message_.sender_user_id_ or false
local gid = tonumber(msg.message_.chat_id_) or false
local mid = msg.message_.id_ or false

if not redis:get('splug:'..gid) then
return msg
end

if msg.message_.content_ and msg.message_.content_.text_ then
local text = msg.message_.content_.text_:lower() or false
else
local text = false
end

 if text and text:match('return') then
 local plug = redis:get('plugname')
 local file = io.open("./plugins/"..plug..'.lua', "w")
    file:write(text)
    file:flush()
    file:close()
	redis:set('splug:'..gid, false)
	redis:set('plugname',false)
	print('plug')
	td.sendText(tonumber(gid), mid, 1, 0, nil, '*plugin has been created!*', 0, 'md', nil, cmd)	
 end
return msg
end

  local function run(msg, matches)
    local plugin = matches[2] or 'not found'
    local receiver = get_receiver(msg)
    
    if is_sudo(msg.from.id) then

	if matches[1] == 'splug' then
	local plug = matches[2]
	if not plugin_exists(plug) then
	return 'plugins does not existed'
	end
	td.sendDocument(receiver, msg.id, 0, 1, nil, ('./plugins/%s.lua'):format(plug), 'plugin name : '..plug)
	end
	if matches[1] == 'cplug' then
	local plug = matches[2]
	redis:set('splug:'..receiver, true)
	redis:set('plugname',plug)
	print('text')
	print('text')
	print('text')
	return 'send plug text for plugin '..plug..'!'
	end
	
	if matches[1] == 'shplug' then
	local plug = matches[2]
	if not plugin_exists(plug) then
	return 'plugins does not existed'
	end
	local text = io.open("./plugins/"..plug..".lua", "r"):read("*all")
	td.sendText(tonumber(msg.to.id), 0, 1, 0, nil, ('text for plugin %s :\n'):format(plug)..''..text..'', 0, nil, nil, cmd)	
	return 
	end
	

	
      if not matches[3] then
        if matches[1] == '+' then
          print("+: " .. plugin)
          print('checking if ' .. plugin .. ' exists')

          -- Check if plugin is enabled
          if plugin_enabled(plugin) then
            reply_msg(msg.id, 'Plugin ' .. plugin .. ' is enabled', ok_cb, true)
          end

          -- Checks if plugin exists
          if plugin_exists(plugin) then
            -- Add to the config table
            table.insert(_config.enabled_plugins, plugin)
            print(plugin .. ' added to _config table')
            save_config()
            -- Reload the plugins
            return reload_plugins(false, msg)
          else
            reply_msg(msg.id, 'Plugin ' .. plugin .. ' does not exists', ok_cb, true)
          end
        end

        -- - a plugin
        if matches[1] == '-' then
          print("-: " .. plugin)

          -- Check if plugins exists
          if not plugin_exists(plugin) then
            reply_msg(msg.id, 'Plugin ' .. plugin .. ' does not exists', ok_cb, true)
          end

          local k = plugin_enabled(plugin)
          -- Check if plugin is enabled
          if not k then
            reply_msg(msg.id, 'Plugin ' .. plugin .. ' not enabled', ok_cb, true)
          end

          -- - and reload
          table.remove(_config.enabled_plugins, k)
          save_config( )
          return reload_plugins(true, msg)
        end
      end

	  if matches[1] == 'enabler' then -- enable all
	  return enable_all()
	  end
      -- Reload all the plugins!
      if matches[1] == 'reload' then
        return reload_plugins(false, msg)
      end
    end

    if is_mod(msg, msg.to.peer_id, msg.from.peer_id) then
      -- Show the available plugins
      if matches[1] == 'plugins' then
        return list_plugins(false, msg)
      end

      -- Re-+ a plugin for this chat
      if matches[3] == 'chat' then
        if matches[1] == '+' then
          print('+ ' .. plugin .. ' on this chat')
          if not _config.disabled_plugin_on_chat then
            reply_msg(msg.id, "There aren't any disabled plugins", ok_cb, true)
          end

          if not _config.disabled_plugin_on_chat[receiver] then
            reply_msg(msg.id, "There aren't any disabled plugins for this chat", ok_cb, true)
          end

          if not _config.disabled_plugin_on_chat[receiver][plugin] then
            reply_msg(msg.id, 'This plugin is not disabled', ok_cb, true)
          end

          _config.disabled_plugin_on_chat[receiver][plugin] = false
          save_config()
          reply_msg(msg.id, 'Plugin ' .. plugin .. ' is enabled again', ok_cb, true)
        end

        -- - a plugin on a chat
        if matches[1] == '-' then
          print('- ' .. plugin .. ' on this chat')
          if not plugin_exists(plugin) then
            reply_msg(msg.id, "Plugin doesn't exists", ok_cb, true)
          end

          if not _config.disabled_plugin_on_chat then
            _config.disabled_plugin_on_chat = {}
          end

          if not _config.disabled_plugin_on_chat[receiver] then
            _config.disabled_plugin_on_chat[receiver] = {}
          end

          _config.disabled_plugin_on_chat[receiver][plugin] = true
          save_config()
          reply_msg(msg.id, 'Plugin ' .. plugin .. ' disabled on this chat', ok_cb, true)
        end
      end
    end
  end

--------------------------------------------------------------------------------

  return {
    description = 'Plugin to manage other plugins. Enable, - or reload.',
    usage = {
        '`plugins + [plugin]`',
        '+ plugin.',
        '',
        '`plugins - [plugin]`',
        '- plugin.',
        '',
        '`reload`',
        'Reloads all plugins.',
        '`plugins`',
        'List all plugins.',
        '',
        '`plugins + [plugin] chat`',
        'Re-+ plugin only this chat.',
        '',
        '`plugins - [plugin] chat`',
        '- plugin only this chat.',
        '',
		'splug (plug name)',
		'send plugin',
		'',
		'shplug (plug name)',
		'show text of plugin',
		'',
    },
    patterns = {
      '^(plugins)$',
	  '^(reload)',
	  '^(splug) (.*)',
	  '^(shplug) (.*)',
	  '^(cplug) (.*)',
	  '^plugins? (enabler)$',
      '^plugins? (+) ([%w_%.%-]+)$',
      '^plugins? (-) ([%w_%.%-]+)$',
      '^plugins? (+) ([%w_%.%-]+) (chat)$',
      '^plugins? (-) ([%w_%.%-]+) (chat)$', 
      '^plugins? (reload)$',
    },
    run = run,
	pre_process = splugin
  }

end
