
function ssave(data, file, extra)
  local data = data or _config
  local file = file or config_file
  file = io.open(file, 'w+')
  local serialized = serpent.block(data, {comment = false, name = '_'})

  if extra then
    if extra == 'noname' then
      serialized = serpent.block(data, {comment=false})
    else
      serialized = serpent.dump(data)
    end
  end
  file:write(serialized)
  file:close()
end 
 function escapeHtml(str)
  return (string.gsub(str, "[}{\">/<'&]", {
    ["&"] = "&amp;",
    ["<"] = "&lt;",
    [">"] = "&gt;",
    ['"'] = "&quot;",
    ["'"] = "&#39;",
    ["/"] = "&#47;"
  }))
end
  local function msgDump(chat_id, msg_id, value, file)
    local dump = serpent.block(value, {comment=false})
    if file then
      local textfile = '/tmp/msgdump_' .. os.date('%y%m%d-%H%M%S', value.date_) .. '.json'
      local info =  _('From: %s\nID: %s\nDate: %s'):format(value.to.id, value.id, os.date('%c', value.date_))
      ssave(dump..'\n\n#os tg\n\n'.. serpent.block(Data, {comment=false}), textfile, 'noname')
      td.sendDocument(chat_id, msg.id, 0, 1, nil, textfile, info)
      -- TODO: delete textfile after it's successfully sent
      --os.remove(textfile)
    else
      if #dump > 4000 then
        local text = _('Message is more than 4000 characters.\n'
                .. 'Use <code>%sdumptext</code> instead.'):format(_config.cmd)
      else
		td.sendText(chat_id, 0, 1, 0, nil, '<code>' .. escapeHtml(dump) .. '</code>', 0, 'html', ok_cb, cmd)


      end
    end
  end

  

  local function sudoByReply(arg, data)
    if arg.cmd == 'dump' then
      msgDump(arg.chat_id, data.id_, data)
    elseif arg.cmd == 'dumptext' then
      msgDump(arg.chat_id, data.id_, data, true)
    else
      td.getUser(data.sender_user_id_, visudo, arg)
    end
  end

--------------------------------------------------------------------------------

  
  
  
 function shellCommand(str)
  local cmd = io.popen(str)
  local result = cmd:read('*all')
  cmd:close()
  return result
end
--------------------------------------------------------------------------------

  function run(msg, matches)
    local chat_id, user_id = msg.to.id , msg.from.id
if not is_sudo(user_id) then
return
end
    if matches[1] == 'bin' or matches[1] == 'run' then
      if not matches[2] then
         
        return _('Please specify a command to run.')
      end

      local input = matches[2]:gsub('—', '--')
      local output = shellCommand(input)

      if #output == 0 then
        output = '*Done!*'
      else
        output =  '`' .. output .. '`'
      end
      return output
    end

    if matches[1] == 'settoken' then
      local token = matches[2]
      local response = {}
      local getme  = https.request{
        url = 'https://api.telegram.org/bot' .. token .. '/getMe',
        method = "POST",
        sink = ltn12.sink.table(response),
      }
      local body = table.concat(response or {"no response"})
      local jbody = json.decode(body)

      if jbody.ok then
        local bot = jbody.result
        _config.api.token = token
        _config.api.id = bot.id
        _config.api.first_name = bot.first_name
        _config.api.username = bot.username
        saveConfig()

        return _('<b>API bots token has been saved</b>')
      else
        return _('<b>Error</b>: ') .. jbody.error_code .. ', ' .. jbody.description
      end
    end

    if matches[1] == 'version' then
      local f = assert(io.popen('/usr/bin/git describe --tags', 'r'))
      local version = assert(f:read('*a'))
      f:close()
      local output = _('<b>tdcliBot</b> <code>%s</code>'):format(version)
      return output
    end

    if matches[1] == 'dump' or matches[1] == 'dumptext' then
      if msg.reply_id then
        td.getMessage(chat_id, msg.reply_id, sudoByReply, {cmd = matches[1], chat_id = chat_id})
      else
        msgDump(chat_id, msg.id, msg, true)
      end
    end

    if matches[1] == 'getconfig'  then
      td.sendDocument(chat_id, 0, 0, 1, nil, 'data/config.lua', os.date('%c', msg.date_))
    end
 if matches[1] == 'exit' then
        td.changeChatMemberStatus(msg.to.id, bot.id, 'Left')

 end
     if matches[1] == 'autoleave' then
      local text
      if matches[2] == 'enable' then
        if _config.autoleave then
          text = _('Autoleave is already enabled.')
        else
          _config.autoleave = true
          text = _('Autoleave has been enabled.')
        end
      end
      if matches[2] == 'disable' then
        if not _config.autoleave then
          text = _('Autoleave is already disabled.')
        else
          _config.autoleave = false
          text = _('Autoleave has been disabled.')
        end
      end
      save_config()
	  return text
	  end
	end

--------------------------------------------------------------------------------

  return {
  description = 'extra commands for sudo users',
    usage = {
    'autoleave (enable)',
	'enabled autoleave for bots.',
	'',
	'autoleave (disable)',
	'disabled autoleave for bots.',
	'',
	'bin (text)',
	'write text in the trminal and show result',
	'',
	'dump',
	'dume msgs',
	'',
	'getconfig',
	'get bot configs',
	'',
	'exit',
	'leave bot from chat',
	'',
	'settoken (token)',
	'set bot token os helper.',
	'',
	'version',
	'show bot version'
    },
    patterns = {
      '^(autoleave) (%w+)$',
      '^(bin) (.*)$',
      '^(run) (.*)$',
      '^(dump)$',
	  '^(exit)',
      '^(dumptext)$',
      '^(getconfig)$',
      '(settoken) (.*)$',
      '^(version)$',

    },
    run = run,
  }
