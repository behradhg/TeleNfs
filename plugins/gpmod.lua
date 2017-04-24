do
  local triggers = {'^(about)$','^(setall)$',
  '^(adminlist)$', '^(adminlist) (%d+)$',
  '^(antispam) (%a+)$',
  '^(arabic) (%a+)$',
  '^(revoke)$',
  '^(links) (%a+)$',
  '^(photo) (%a+)$',
  '^(cmds) (.*)$',
  '^(gif) (%a+)$',
  '^(fwd) (%a+)$',
  '^(video) (%a+)$',
  '^(warnmod) (%a+)$',
  '^(warnmax) (%d+)$','^(warn) (@)(%g+)$', '^(warn) (.*)$','^(warn)$','^(unwarn)$',
  '^(autoleave) (%a+)$','^(banlist)$',
  '^(bc) (%d+) (.*)$',
  '^(filter) (.*) (.*)$','^(unfilter) (.*)$','^(filterlist)$','^(filters)$',
  '^(broadcast) (.*)$','^(backup)$',
  '^(channel) (%a+)$',
  '^(clear) (%a+)$',
  '^(group) (%a+)$',
  '^(getconfig)$', '^(getconfig) (%d+)$',
  '^(grouplist)$', '^(groups)$', '^(gllist)$',
  '^(joinrealm)$',
  '^(kickme)$',
  '^(leave)$',
  '^(leaveall)$',
  '^(link revoke)$',
  '^(mkgroup) (.*)$',
  '^(add)(realm)$',
  '^(mk)(realm) (.*)$',
  '^(token)$',
  '^(removerealm)$',
  '^(mksupergroup) (.*)$',
  '^(modlist)$', '^(modlist) (%d+)$',
  '^(ownerlist)$', '^(ownerlist) (%d+)$',
  '^(rules)$',
  '^(setabout) (.*)$',
  '^(setname) (.*)$',
  '^(setphoto)$',
  '^(setprivate)$',
  '^(settings)$',
  '^(setpublic)$',
  '^(setrules) (.*)$',
  '^(setwelcome) (.*)$',
  '^(resetwelcome)$',
  '^(sticker) (%a+)$',
  '^(sudolist)$',
  '^(unwhitelist) (chat) (%d+)$',
  '^(version)$',
  '^(warnlist)$',
  '^(warnlist)$',
  '^(welcome) (%a+)$',
  '^(whitelist) (%a+)$',
  '^(whitelist) (chat) (%d+)$',
  '^(superbanlist)$', '^(gbanlist)$', '^(hammerlist)$',
  '^(whitelist)$', '^(whitelist) (@)(%g+)$', '^(whitelist)(%s)(%d+)$',
  '^(unwhitelist)$', '^(unwhitelist) (%g+)$', '^(unwhitelist) (@)(%g+)$', '^(unwhitelist)(%s)(%d+)$',
  '^(addgroup)$', '^(gadd)$', '^(addgroup) (%d+)$', '^(gadd) (%d+)$',
  '^(visudo)$', '^(visudo) (@)(%g+)$', '^(visudo)(%s)(%d+)$', '^(visudo) (@)(%g+) (%d+)$', '^(visudo)(%s)(%d+) (%d+)$',
  '^(sudo)$', '^(sudo) (@)(%g+)$', '^(sudo)(%s)(%d+)$', '^(sudo) (@)(%g+) (%d+)$', '^(sudo)(%s)(%d+) (%d+)$',
  '^(desudo)$', '^(desudo) (@)(%g+)$', '^(desudo)(%s)(%d+)$', '^(desudo) (@)(%g+) (%d+)$', '^(desudo)(%s)(%d+) (%d+)$',
  '^(admin)$', '^(admin) (@)(%g+)$', '^(admin)(%s)(%d+)$', '^(admin) (@)(%g+) (%d+)$', '^(admin)(%s)(%d+) (%d+)$',
  '^(adminprom)$', '^(adminprom) (@)(%g+)$', '^(adminprom)(%s)(%d+)$', '^(adminprom) (@)(%g+) (%d+)$', '^(adminprom)(%s)(%d+) (%d+)$',
  '^(ban)$', '^(ban) (@)(%g+)$', '^(ban)(%s)(%d+)$', '^(ban) (%w+)(%s)(%d+)$',
  '^(deadmin)$', '^(deadmin) (@)(%g+)$', '^(deadmin)(%s)(%d+)$', '^(deadmin) (@)(%g+) (%d+)$', '^(deadmin)(%s)(%d+) (%d+)$',
  '^(admindem)$', '^(admindem) (@)(%g+)$', '^(admindem)(%s)(%d+)$', '^(admindem) (@)(%g+) (%d+)$', '^(admindem)(%s)(%d+) (%d+)$',
  '^(demote)$', '^(demote) (@)(%g+)$', '^(demote)(%s)(%d+)$',
  '^(demod)$', '^(demod) (@)(%g+)$', '^(demod)(%s)(%d+)$',
  '^(grem)$', '^(grem) (%d+)$', '^(gremove)$', '^(gremove) (%d+)$', '^(remgroup)$', '^(remgroup) (%d+)$',
  '^(group) (lock) (%a+)$', '^(gp) (lock) (%a+)$',
  '^(group) (settings)$', '^(gp) (settings)$',
  '^(group) (unlock) (%a+)$', '^(gp) (unlock) (%a+)$',
  '^(invite)$', '^(invite) (enable)$', '^(invite) (disable)$', '^(invite) (@)(%g+)$', '^(invite)(%s)(%g+)$',
  '^(kick)$', '^(kick) (@)(%g+)$', '^(kick)(%s)(%d+)$', '^(kick) (%d+) (%d+)$', '^(kick) (@)(%g+) (%d+)$', '^(kick)(%s)(%d+) (%d+)$',
  '^(link)$', '^(link get)$', '^(getlink)$',
  '^(link set)$', '^(setlink)$', '^(link set) (.*)$', '^(setlink) (.*)$',
  '^(setleader)$', '^(setleader) (@)(%g+)$','^(setleader) (%d+)$',
  '^(gl)$', '^(gl) (@)(%g+)$', '^(gl) (%d+)$', '^(gl) (@)(%g+)$', '^(gl)(%s)(%d+) (%d+)$',
  '^(degl)$', '^(degl) (@)(%g+)$', '^(degl)(%s)(%d+)$', '^(degl) (@)(%g+) (%d+)$', '^(degl)(%s)(%d+) (%d+)$',
  '^(remleader)$', '^(remleader) (@)(%g+)$', '^(remleader)(%s)(%d+)$', '^(remleader) (@)(%g+) (%d+)$', '^(remleader)(%s)(%d+) (%d+)$',
  '^(setowner)$', '^(setowner) (@)(%g+)$', '^(setowner)(%s)(%d+)$', '^(setowner) (@)(%g+) (%d+)$', '^(setowner)(%s)(%d+) (%d+)$',
  '^(gov)$', '^(gov) (@)(%g+)$', '^(gov)(%s)(%d+)$', '^(gov) (@)(%g+) (%d+)$', '^(gov)(%s)(%d+) (%d+)$',
  '^(degov)$', '^(degov) (@)(%g+)$', '^(degov)(%s)(%d+)$', '^(degov) (@)(%g+) (%d+)$', '^(degov)(%s)(%d+) (%d+)$',
  '^(remowner)$', '^(remowner) (@)(%g+)$', '^(remowner)(%s)(%d+)$', '^(remowner) (@)(%g+) (%d+)$', '^(remowner)(%s)(%d+) (%d+)$',
  '^(mod)$', '^(mod) (@)(%g+)$', '^(mod)(%s)(%d+)$', '^(mod) (@)(%g+) (%d+)$', '^(mod)(%s)(%d+) (%d+)$',
  '^(promote)$', '^(promote) (@)(%g+)$', '^(promote)(%s)(%d+)$', '^(promote) (@)(%g+) (%d+)$', '^(promote)(%s)(%d+) (%d+)$',
  '^(superban)$', '^(superban) (@)(%g+)$', '^(superban)(%s)(%d+)$', '^(superban) (@)(%g+) (%d+)$', '^(superban)(%s)(%d+) (%d+)$',
  '^(hammer)$', '^(hammer) (@)(%g+)$', '^(hammer)(%s)(%d+)$', '^(hammer) (@)(%g+) (%d+)$', '^(hammer)(%s)(%d+) (%d+)$',
  '^(gban)$', '^(gban) (@)(%g+)$', '^(gban)(%s)(%d+)$', '^(gban)(%s)(%d+) (%d+)$', '^(gban) (@)(%g+) (%d+)$',
  '^(superunban)$', '^(superunban) (@)(%g+)$', '^(superunban)(%s)(%d+)$', '^(superunban) (@)(%g+) (%d+)$', '^(superunban)(%s)(%d+) (%d+)$',
  '^(unhammer)$', '^(unhammer) (@)(%g+)$', '^(unhammer)(%s)(%d+)$', '^(unhammer) (@)(%g+) (%d+)$', '^(unhammer)(%s)(%d+) (%d+)$',
  '^(gunban)$', '^(gunban) (@)(%g+)$', '^(gunban)(%s)(%d+)$', '^(gunban) (@)(%g+) (%d+)$', '^(gunban)(%s)(%d+) (%d+)$',
  '^(unban)$', '^(unban) (@)(%g+)$', '^(unban)(%s)(%d+)$', '^(unban) (%g+) (%d+)$',
}

local plugins = {}
local bot_repo = 'https://github.com/behradhg/TeleNfs'

function is_banned(chat_id, user_id)
  local hash = 'banned:' .. chat_id
  local banned = redis:sismember(hash, user_id)
  return banned or false
end

function is_globally_banned(user_id)
  local hash = 'globanned'
  local banned = redis:sismember(hash, user_id)
  return banned or false
end


function math:source(d , l)
local h,m,mo = 0,0,0
if d >= 30 then 
while d >= 30 do
 d =  d - 30 mo = mo + 1 
 end end
 if l then
 text = math.ceil(mo)..'~m'..d..'~d'
 else 
 text = math.ceil(mo)..' ماه '..d..' روز '
 end
return  text
end


local function is_privileged(msg, gid, uid)
  local var = false
  if is_mod(msg, gid, uid) or uid == our_id or uid == tonumber(_config.api.id) or is_sudo(msg,uid) then
    var = true
  end
  return var
end

local function get_sudolist(msg)
  local sudoers = _("list of sudo users:\n\n")
    for k,v in pairs(_config.sudo_users) do
      sudoers = sudoers .. '- ' .. get_uname(v) .. ' - `' .. k .. '`\n'
    end
    reply_msg(msg.id, sudoers, ok_cb, true)
  end

  local function get_adminlist(msg, gid)
    local group = gid or msg.to.title
    if is_administrate(msg, gid) then
      if next(_config.administrators) == nil then
        reply_msg(msg.id, _('There are currently no listed administrators'), ok_cb, true)
      else
        local message = _("List of administrators:\n\n")
        for k,v in pairs(_config.administrators) do
		  message = message .. '- ' .. get_uname(v) .. ' - `' .. k .. '`\n'
        end
        reply_msg(msg.id, message, ok_cb, true)
      end
    end
  end

  local function del_adminlist(msg, gid)
    local group = gid or msg.to.title
    if is_administrate(msg, gid) then
      if next(_config.administrators) == nil then
        reply_msg(msg.id, _('There are currently no listed administrators.'), ok_cb, true)
      else
        _config.administrators = {}
        save_config()
        reply_msg(msg.id, _('All administrators has been demoted.'), ok_cb, true)
      end
    end
  end

  local function clean_msg(extra ,msg)
    for i=0,#msg.messages_  do
      local msg = msg.messages_[i]
      local uid = msg.sender_user_id_
      delete_all_msg(extra.gid,uid)
    end
  end
  
  
  local function get_ownerlist(msg, chat_id)
    local gid = tonumber(chat_id)
    local group = msg.to.title or gid
    local data = load_data(_config.chats.managed[gid])
    if is_administrate(msg, gid) then
      if next(data.owners) == nil then
        reply_msg(msg.id, _('There are currently no listed owners.'), ok_cb, true)
      else
        local message = _("*list of ownerlist :\n\n*")
        for k,v in pairs(data.owners) do
          message = message .. '- *' .. get_uname(v) .. '* - `' .. k .. '`\n'
        end
        reply_msg(msg.id, message, ok_cb, true)
      end
    end
  end

  local function del_ownerlist(msg, gid)
    local group = gid or msg.to.title
    if is_administrate(msg, gid) then
      local data = load_data(_config.chats.managed[gid])
      if next(data.owners) == nil then
        reply_msg(msg.id, _('There are currently no listed owners.'), ok_cb, true)
      else
        data.owners = {}
        save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
		local text = _('All of %s owners has been demoted.'):format(group)
        reply_msg(msg.id,text:format(group), ok_cb, true)
      end
    end
  end

  local function get_modlist(msg, gid)
    local gid = tonumber(gid)
    if is_administrate(msg, gid) then
      local data = load_data(_config.chats.managed[gid])
      if next(data.moderators) == nil then
        reply_msg(msg.id, _('There are currently no listed moderators.'), ok_cb, true)
      else
        local message = _("list of mod users for group :\n")
        for k,v in pairs(data.moderators) do
		message = message .. '- ' .. get_uname(v) .. ' - `' .. k .. '`\n'
        end
        reply_msg(msg.id, message, ok_cb, true)
      end
    end
  end

  local function del_modlist(msg, gid)
    if is_administrate(msg, gid) then
      local data = load_data(_config.chats.managed[gid])
      if next(data.moderators) == nil then
        reply_msg(msg.id, _('There are currently no listed moderators.'), ok_cb, true)
      else
        data.moderators = {}
        save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
		local text = _('All of %s moderators has been demoted.')
        reply_msg(msg.id,text:format(data.name), ok_cb, true)
      end
    end
  end

  local function clean_bots(extra,msg) -- clean bots function
  local our_id = 315115554
  local helper_id = config.api.id
    for i=0,#msg.members_ do
      local uid = msg.members_[i].user_id_
	  if uid ~= our_id then
	  elseif uid ~= helper_id then
	  else
      td.changeChatMemberStatus(extra.gid, uid, 'Kicked')
	  end
    end
  end

  local function update_members_list(extra, success, result)   -- os update
    if extra.to.peer_type == 'channel' then
      chat_id = extra.to.peer_id
      member_list = result
    else
      chat_id = result.peer_id
      member_list = result.members
    end
    local gid = tonumber(chat_id)
    local data = load_data(_config.chats.managed[gid])
    for k,v in pairsByKeys(member_list) do
      data.members[v.peer_id] = v.username or ''
    end
    save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
  end

  -- kick user
  local function kick_user(msg, chat_id, user_id)
    local gid = tonumber(chat_id)
    local uid = tonumber(user_id)
      if is_privileged(msg, gid, uid) then
        reply_msg(msg.id, uid .. ' is too privileged to be kicked.', ok_cb, true)
      else
       td.changeChatMemberStatus(gid, uid, 'Kicked')
      end
  end


  function ban_user(extra, gid, uid)
    local msg = extra.msg
    local usr = extra.usr
    local data = load_data(_config.chats.managed[gid])
    if is_privileged(msg, gid, uid) then
      reply_msg(msg.id, usr .. ' is too privileged to be banned.', ok_cb, true)
    else
      if is_banned(gid, uid) then
        reply_msg(msg.id, usr .. _(' is already banned.'), ok_cb, true)
      else
        local hash = 'banned:' .. gid
        redis:sadd(hash, uid)
        kick_user(msg, gid, uid)
        data.banned[uid] = usr
        save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
        reply_msg(msg.id, usr .. _(' has been banned.'), ok_cb, true)
      end
    end
  end

  function mem(arg, data)
			local text =''
			local num = 1
			local mode = arg.model
			for k,v in pairs(data.members_) do
				userid = v.user_id_
				function mem_cb(arg, data)
				if data.username_ then
					user_name = "@"..data.username_
				else
					user_name = '<i>No Username</>'
				end
				if data.type_.ID == 'UserTypeDeleted' then
				text = text..'\n<code>'..num..'-</> <b>Deleted Account</> - <code>'..data.id_..'</>'
				num = num + 1
				else
				text = text..'\n<code>'..num..'-</> '..user_name..' - <code>'..data.id_..'</>'
				num = num + 1
				end
				if tonumber(k) == 0 then
					if mode == 'all' then
						td.sendMessage(msg.to.id, 0,1, '<b>Group Member:</> '..text..'',1,'html')
					end
					if mode == 'admin' then
						td.sendMessage(msg.to.id, 0,1, '<b>Administrators:</> '..text..'',1,'html')
				end
			if mode == 'kick' then
				td.sendMessage(msg.to.id, 0,1, '<b>Kicked:</> '..text..'',1,'html')
			end
			if mode == 'bot' then
				td.sendMessage(msg.to.id, 0,1, '<b>Bots Member:</> '..text..'',1,'html')
			end
				end
				end
				
				td.getUser(userid, mem_cb, nil )
				end
				
end
  
  function warn(extra, gid, uid)
    local msg = extra.msg
    local usr = extra.usr
    data = load_data(_config.chats.managed[gid])
    local user_warn = tonumber(data.warn_counter[uid]) or 0
    local max_warn = tonumber(data.warn_settings.max_warn) or 5
    if is_privileged(msg, gid, uid) then
     return reply_msg(msg.id, usr .. ' is too privileged to be warning.', ok_cb, true)
    end
    if user_warn >= max_warn then
      kick_user(msg, gid, uid)
      data.warn_counter[uid] = nil
      reply_msg(msg.id, usr .. _(' is kicked with warning.'), ok_cb, true)
      return save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
    end
    data.warn_counter[uid] = user_warn + 1
    save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
    local text = usr.. _(' warning %s time.')
    reply_msg(msg.id, text:format(data.warn_counter[uid]), ok_cb, true)

  end

  function unwarn(extra, gid, uid)
    local msg = extra.msg
    local usr = extra.usr
    data = load_data(_config.chats.managed[gid])
    local user_warn = tonumber(data.warn_counter[uid]) or 0
    local max_warn = tonumber(data.warn_settings.max_warn) or 5
    if user_warn <= 0 then
      return    reply_msg(msg.id, usr.. _('user doesnt have warn'), ok_cb, true)
    end
    data.warn_counter[uid] = user_warn - 1
    save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
    if data.warn_counter[uid] == 0 then
      data.warn_counter[uid] = nil
    end
    save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')

    local text = usr.. _(' unwarning \nwarn count %s time.')
    reply_msg(msg.id, text:format(data.warn_counter[uid]), ok_cb, true)

  end

  function global_ban_user(extra, gid, uid)
    local msg = extra.msg
    if is_privileged(msg, gid, uid) then
      reply_msg(msg.id, uid .. ' is too privileged to be globally banned.', ok_cb, true)
    elseif is_globally_banned(uid) then
      reply_msg(msg.id, extra.usr .. ' is already globally banned.', ok_cb, true)
    else
      local hash = 'globanned'
      redis:sadd(hash, uid)
      kick_user(extra.msg, gid, uid)
      _config.globally_banned[uid] = extra.usr
      save_config()
      reply_msg(extra.msg.id, extra.usr .. ' has been globally banned.', ok_cb, true)
    end
  end

  function unban_user(extra, gid, uid)
    if is_banned(gid, uid) then
      local hash = 'banned:' .. gid
      local data = load_data(_config.chats.managed[gid])
      redis:srem(hash, uid)
      data.banned[uid] = nil
      save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
      reply_msg(extra.msg.id, extra.usr .. ' has been unbanned.', ok_cb, true)
    else
      reply_msg(extra.msg.id, extra.usr .. ' is not banned.', ok_cb, true)
    end
  end

  function global_unban_user(extra, user_id)
    if is_globally_banned(user_id) then
      local hash = 'globanned'
      redis:srem(hash, user_id)
      _config.globally_banned[user_id] = nil
      save_config()
      reply_msg(extra.msg.id, extra.usr .. ' has been globally unbanned.', ok_cb, true)
    else
      reply_msg(extra.msg.id, extra.usr .. ' is not globally banned.', ok_cb, true)
    end
  end

  function whitelisting(extra, chat_id, user_id)
    local hash = 'whitelist'
    local is_whitelisted = redis:sismember(hash, user_id)
    if is_whitelisted then
      reply_msg(extra.msg.id, extra.usr .. ' is already whitelisted.', ok_cb, true)
    else
      redis:sadd(hash, user_id)
      reply_msg(extra.msg.id, extra.usr .. ' added to whitelist.', ok_cb, true)
    end
  end

  function unwhitelisting(extra, chat_id, user_id)
    local hash = 'whitelist'
    local is_whitelisted = redis:sismember('whitelist', user_id)
    if not is_whitelisted then
      reply_msg(extra.msg.id, extra.usr .. ' is not whitelisted.', ok_cb, true)
    else
      redis:srem(hash, user_id)
      reply_msg(extra.msg.id, extra.usr .. ' removed from whitelist', ok_cb, true)
    end
  end

  function promote(extra, chat_id, user_id)
    local gid = tonumber(chat_id)
    local uid = tonumber(user_id)
    local data = load_data(_config.chats.managed[gid])
    if data.moderators ~= nil and data.moderators[uid] then
      reply_msg(extra.msg.id, uid .. ' is already a moderator.', ok_cb, true)
    else
      data.moderators[uid] = extra.usr
      save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
      reply_msg(extra.msg.id, extra.usr .. ' is now a moderator.', ok_cb, true)
    end
  end

  function demote(extra, chat_id, user_id, force)
    local gid = tonumber(chat_id)
    local uid = tonumber(user_id)
    local data = load_data(_config.chats.managed[gid])
    if not data.moderators[uid] then
      reply_msg(extra.msg.id, uid .. ' is not a moderator.', ok_cb, true)
    elseif uid == extra.msg.from.peer_id and not force then
      reply_msg(extra.msg.id, "You can't demote yourself.", ok_cb, true)
    else
      data.moderators[uid] = nil
      save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
      reply_msg(extra.msg.id, extra.usr .. ' is no longer a moderator.', ok_cb, true)
    end
  end
  
   function promote_leader(extra, chat_id, user_id)
    local gid = tonumber(chat_id)
    local uid = tonumber(user_id)
    local data = load_data(_config.chats.managed[gid])
    if data.leader == uid then
      reply_msg(extra.msg.id, uid .. ' is already the group leader.', ok_cb, true)
    else
      data.leader = uid
      save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
      reply_msg(extra.msg.id, extra.usr .. ' is now the group leader.', ok_cb, true)
    end
  end

  function promote_owner(extra, chat_id, user_id)
    local gid = tonumber(chat_id)
    local uid = tonumber(user_id)
    local data = load_data(_config.chats.managed[gid])
    vardump(data)
    if data.owners[uid] then
      reply_msg(extra.msg.id, uid .. ' is already the group owner.', ok_cb, true)
    else
      data.owners[uid] = extra.usr
      save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
      reply_msg(extra.msg.id, extra.usr .. ' is now the group owner.', ok_cb, true)
    end
  end

  function demote_owner(extra, chat_id, user_id, force)
    local gid = tonumber(chat_id)
    local uid = tonumber(user_id)
    local data = load_data(_config.chats.managed[gid])
    if not data.owners[uid] then
      reply_msg(extra.msg.id, uid .. ' is not the group owner.', ok_cb, true)
    elseif uid == extra.msg.from.peer_id and not force then
      reply_msg(extra.msg.id, "You can't demote yourself.", ok_cb, true)
    else
      data.owners[uid] = nil
      save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
      reply_msg(extra.msg.id, extra.usr .. ' is no longer the group owner.', ok_cb, true)
    end
  end

  function promote_admin(extra, user_id)
    local uid = tonumber(user_id)
    if _config.administrators[uid] then
      reply_msg(extra.msg.id, extra.usr .. ' is already an administrator.', ok_cb, true)
    else
      td.changeChatMemberStatus(extra.msg.to.id, uid, 'Moderator')
      _config.administrators[uid] = extra.usr
      save_config()
      reply_msg(extra.msg.id, extra.usr .. ' is now an administrator.', ok_cb, true)
    end
  end

  function demote_admin(extra, user_id, force)
    local uid = tonumber(user_id)
    if not _config.administrators[uid] then
      reply_msg(extra.msg.id, extra.usr .. ' is not an administrator.', ok_cb, true)
    elseif uidb == extra.msg.from.peer_id and not fborce then
      reply_msg(extra.msg.id, "You can't demote yourself.", ok_cb, true)
    else
      td.changeChatMemberStatus(extra.msg.to.id, uid, 'Member')
      _config.administrators[uid] = nil
      save_config()
      reply_msg(extra.msg.id, extra.usr .. ' is no longer an administrator.', ok_cb, true)
    end
  end

  function visudo(extra, user_id)
    print('to sudo')
    vardump(extra)
    local uid = tonumber(user_id)
    if _config.sudo_users[uid] then
      print('first')
      reply_msg(extra.msg.id, extra.usr .. ' is already a sudoer.', ok_cb, true)
    else
      _config.sudo_users[uid] = extra.usr
      save_config()
      print('first')
      reply_msg(extra.msg.id, extra.usr .. ' is now a sudoer.', ok_cb, true)
    end
  end

  function desudo(extra, user_id, force)
    local uid = tonumber(user_id)
    if not _config.sudo_users[uid] then
      reply_msg(extra.msg.id, extra.usr .. ' is not a sudoer.', ok_cb, true)
    elseif uid == extra.msg.from.peer_id and not force then
      reply_msg(extra.msg.id, "You can't demote yourself.", ok_cb, true)
    else
      _config.sudo_users[uid] = nil
      save_config()
      reply_msg(extra.msg.id, extra.usr .. ' is no longer a sudoer.', ok_cb, true)
    end
  end

  function get_redis_ban_records()
    for gid,cfg in pairs(_config.chats.managed) do
      local data = load_data(_config.chats.managed[gid])
      local banlist = redis:smembers('banned:' .. gid)
      if not data.banned then
        data.banned = {}
      end
      for x,uid in pairs(banlist) do
        data.banned[tonumber(uid)] = ''
      end
      save_data(data, cfg)
    end
    local globanlist = redis:smembers('globanned')
    if not _config.globally_banned then
      globally_banned = {}
    end
    for k,uid in pairs(globanlist) do
      _config.globally_banned[tonumber(uid)] = ''
    end
    save_config()
  end



  function config_admins(extra , data)
  local min = data.members_
  c = load_data(_config.chats.managed[extra.gid])
  local a,b,f = 0,0,c.moderators
  for x = 0 , #min do
  local uid = min[x].user_id_
  if f[uid] then
  a = a + 1
  else
  c.moderators[uid] = "#by setall"
  b = b + 1
  end
  end
  save_data(c , _config.chats.managed[extra.gid])
  reply_msg(extra.msg.id, 'config admin list : \nnew admins ; '..a..'\nlast update : '..b..'', ok_cb, true)
  end
  
  function get_username(msg)
    if msg.from.username then
      username = '@' .. msg.from.username
    elseif msg.from.first_name then
      username = msg.from.first_name
    else
      username = get_uname(msg.from.peer_id)
    end
    return username
  end

  function create_group_data(msg, chat_id, user_id)
    local l_name = get_uname(user_id)
    if msg.action then
      t_name = _config.mkgroup.founder
    end
    gpdata = {
      antispam = {
        action = 'ban',
        NUM_MSG_MAX = 4,  -- Max number of messages per TIME_CHECK seconds
        TIME_CHECK = 4
      },
	  rank = {},
      banned = {},
      founded = os.time(),
      founder = '',
      group_type = msg.to.peer_type,
      link = '',
	  leader = user_id,
      mute_list = {},
      mute_user = {},
      warn_settings = {
        max_warn = 5,
        action = 'ban'
      },
      whitelist = {},
      mute = {},
      warn_counter = {},
      filters = {},
      lock = {
        arabic = 'ok',
        fwd = 'ok',
        photo = 'ok',
        gif = 'ok',
        links = 'ok',
        video = 'ok',
        bot = 'no',
        member = 'no',
        name = 'yes',
        all = 'no',
        photo = 'yes',
        sticker = 'ok',
      },
      members = {},
      moderators = {},
      name = msg.to.title,
      owners = {[user_id] = t_name or l_name},
      public = true,
      set = {
        name = msg.to.title,
        photo = 'data/' .. chat_id .. '/' .. chat_id .. '.jpg',
      },
      username = msg.to.username or '',
      welcome = {
        to = 'group',
        pm = 'hello %s to group chat',
        stats = 'enable',
      },
    }
    save_data(gpdata, 'data/' .. chat_id .. '/' .. chat_id .. '.lua')
  end

  -- [pro|de]mote|admin[prom|dem]|[global|un]ban|kick|[un]whitelist by reply
  function action_by_reply(extra, success, result)
    local gid = tonumber(extra.to.peer_id)
    local uid = tonumber(result.from.peer_id)
    local usr = get_uname(uid)
    local cmd = extra.text:gsub('[/!#]', '')

    if cmd:match('^kick') then
      kick_user(extra, gid, uid)
    end
    if cmd:match('^visudo') or cmd:match('^sudo') then
      visudo({msg=extra, usr=usr}, uid)
    end
    if cmd:match('^desudo') then
      desudo({msg=extra, usr=usr}, uid)
    end
    if cmd:match('^warn') then
      warn({msg=extra, usr=usr}, gid, uid)
    end
    if cmd:match('^unwarn') then
      unwarn({msg=extra, usr=usr}, gid, uid)
    end
    if cmd:match('^adminprom') or cmd:match('^admin') then
      promote_admin({msg=extra, usr=usr}, uid)
    end
    if cmd:match('^admindem') or cmd:match('^deadmin') then
      demote_admin({msg=extra, usr=usr}, uid)
    end
	if cmd:match('^setleader') or cmd:match('^gl') then
      promote_leader({msg=extra, usr=usr}, gid, uid)
    end

    if cmd:match('^setowner') or cmd:match('^gov') then
      promote_owner({msg=extra, usr=usr}, gid, uid)
    end
    if cmd:match('^remowner') or cmd:match('^degov') then
      demote_owner({msg=extra, usr=usr}, gid, uid)
    end
    if cmd:match('^promote') or cmd:match('^mod') then
      promote({msg=extra, usr=usr}, gid, uid)
    end
    if cmd:match('^demote') or cmd:match('^demod') then
      demote({msg=extra, usr=usr}, gid, uid)
    end
    if cmd:match('^invite') then
      invite_user(extra, gid, uid)
    end
    if cmd:match('^ban') then
      ban_user({msg=extra, usr=usr}, gid, uid)
    end
    if cmd:match('^superban') or cmd:match('^gban') or cmd:match('^hammer') then
      global_ban_user({msg=extra, usr=usr}, gid, uid)
    end
    if cmd:match('^unban') then
      unban_user({msg=extra, usr=usr}, gid, uid)
    end
    if cmd:match('^superunban') or cmd:match('^gunban') or cmd:match('^unhammer') then
      global_unban_user({msg=extra, usr=usr}, uid)
    end
    if cmd:match('^whitelist') then
      whitelisting({msg=extra, usr=usr}, gid, uid)
    end
    if cmd:match('^unwhitelist') then
      unwhitelisting({msg=extra, usr=usr}, gid, uid)
    end
  end


  -- [pro|de]mote|admin[prom|dem]|[global|un]ban|kick|[un]whitelist by username
  function resolve_username_cb(extra, success, result)
    local msg = extra.msg
    local uid = result.peer_id
    local cmd = extra.matches[1]
    usr = get_uname(uid)

    gid = msg.to.peer_id
    if cmd == 'kick' then
      kick_user(msg, gid, uid)
    end
    if cmd == 'invite' or cmd == 'gadd' then
      invite_user(msg, gid, uid)
    end
    if cmd == 'ban' then
      ban_user({msg=msg, usr=usr}, gid, uid)
    end
    if cmd == 'superban' or cmd == 'gban' or cmd == 'hammer' then
      global_ban_user({msg=msg, usr=usr}, gid, uid)
    end
    if cmd == 'unban' then
      unban_user({msg=msg, usr=usr}, gid, uid)
    end
    if cmd == 'superunban' or cmd == 'gunban' or cmd == 'unhammer' then
      global_unban_user({msg=msg, usr=usr}, uid)
    end
    if cmd == 'visudo' or cmd == 'sudo' then
      visudo({msg=msg, usr=usr}, uid)
    end
    if cmd == 'warn' then
      warn({msg=msg, usr=usr}, gid, uid)
    end
    if cmd == 'unwarn' then
      unwarn({msg=msg, usr=usr}, gid, uid)
    end
    if cmd == 'desudo' then
      desudo({msg=msg, usr=usr}, uid)
    end
    if cmd == 'admin' or cmd == 'adminprom' then
      promote_admin({msg=msg, usr=usr}, uid)
    end
    if cmd == 'deadmin' or cmd == 'admindem' then
      demote_admin({msg=msg, usr=usr}, uid)
    end
	if cmd == 'setleader' or cmd == 'gl' then
      promote_leader({msg=msg, usr=usr}, gid, uid)
    end

    if cmd == 'setowner' or cmd == 'gov' then
      promote_owner({msg=msg, usr=usr}, gid, uid)
    end
    if cmd == 'remowner' or cmd == 'degov' then
      demote_owner({msg=msg, usr=usr}, gid, uid)
    end
    if cmd == 'promote' or cmd == 'mod' then
      promote({msg=msg, usr=usr}, gid, uid)
    end
    if cmd == 'demote' or cmd == 'demod' then
      demote({msg=msg, usr=usr}, gid, uid)
    end
    if cmd == 'whitelist' then
      whitelisting({msg=msg, usr=usr}, gid, uid)
    end
    if cmd == 'unwhitelist' then
      unwhitelisting({msg=msg, usr=usr}, gid, uid)
    end

  end

  -- trigger anti spam and anti flood
  function trigger_anti_spam(extra, chat_id, user_id)
    local data = load_data(_config.chats.managed[chat_id])
    if data.antispam.action == 'kick' then
      kick_user(extra.msg, chat_id, user_id)
      reply_msg(extra.msg.id, extra.usr .. ' is ' .. extra.stype)
    elseif data.antispam.action == 'ban' then
      ban_user({msg=extra.msg, usr=extra.usr}, chat_id, user_id)
      reply_msg(extra.msg.id, extra.usr .. ' is ' .. extra.stype .. '. Banned')
    end
    if not is_chat_msg(extra.msg) then
      send_msg(get_receiver(extra.msg), extra.usr .. ' is ' .. extra.stype .. '. Blocked.', ok_cb, true)
      block_user('user#id' .. user_id, ok_cb, false)
    end
    msg = nil
  end

  function log_error(error)
    if error.ID ~= 'Error' then
      return false
    end
    reply_msg(msg.id, 'Error '..error.code_..':\n'..error.message_, ok_cb, true)
    return true
  end

  -- callback for invite link
  function set_group_link_cb(extra, result)

    if   log_error(result) then
      return
    end
    local data = load_data(extra.file)
    data.link = result.invite_link_
    save_data(data, extra.file)
    if extra.mute == 'revoke' then
      data.link = 'revoked'
      save_data(data, extra.file)
    elseif extra.mute ~= true then
      reply_msg(extra.msg.id, result.invite_link_, ok_cb, true)
    end
  end

  -- set chat|channel invite link
  function set_group_link(extra, file, mute)
    td.exportChatInviteLink(extra.gid,set_group_link_cb,{mute=mute,file=file,msg=extra.msg})
  end

  -- set chat|group photo
  function set_group_photo(extra, success, result)
    local data = extra.data
    local msg = extra.msg
    if success then
      local filepath = 'data/' .. msg.to.peer_id .. '/' .. msg.to.peer_id
      print('File downloaded to:', result)
      os.rename(result, filepath .. '.jpg')
      print('File moved to:', filepath .. '.jpg')
      if msg.to.peer_type == 'channel' then
        channel_set_photo(get_receiver(msg), filepath .. '.jpg', ok_cb, false)
      else
        chat_set_photo(get_receiver(msg), filepath .. '.jpg', ok_cb, false)
      end
      data.set.photo = filepath .. '.jpg'
      save_data(data, filepath .. '.lua')
      data.lock.photo = 'yes'
      save_data(data, filepath .. '.lua')
      reply_msg(msg.id, 'Photo saved!', ok_cb, false)
    else
      print('Error downloading: ' .. msg.id)
      reply_msg(msg.id, 'Error downloading this photo, please try again.', ok_cb, false)
    end
  end

  function load_group_photo(msg, gid)
    local g_type = msg.to.peer_type
    local dl_dir = '.telegram-cli/downloads'
    local cmd = 'load_%s_photo %s#id%s'
    local command = cmd:format(g_type, g_type, gid)
    os.execute('mv ' .. dl_dir .. ' ' .. dl_dir .. '-bak && mkdir ' .. dl_dir)
    os.execute(tgclie:format(command))
    local g_photo = scandir(dl_dir)
    if g_photo[3] and g_photo[3]:match('jpg') then
      os.rename(dl_dir .. '/' .. g_photo[3], 'data/' .. gid .. '/' .. gid .. '.jpg')
      os.execute('rm -r ' .. dl_dir .. ' && mv ' .. dl_dir .. '-bak ' .. dl_dir)
    end
  end

  function add_group(msg, chat_id, user_id)
    local gid = tonumber(chat_id)
    local group = msg.to.title or gid
    local cfg = 'data/' .. gid .. '/' .. gid .. '.lua'
    if _config.chats.managed[gid] then
      reply_msg(msg.id, _("Group is arealy added"), ok_cb, true)
    else
	-- set os api
	-- print(config.api.id)
	-- print(gid) 
	 addChatMembers(gid, {[0] = config.api.id}, nil, cmd)
	-- exe -- batch file
      os.execute('mkdir -p data/' .. gid)
      _config.chats.managed[gid] = cfg
      save_config()
      create_group_data(msg, gid, user_id)
      -- get_redis_ban_records() 
      reply_msg(msg.id, _("Super group has been added"), ok_cb, true)
    end
  end

  function remove_group(msg, chat_id)
    local gid = tonumber(chat_id)
    local group = msg.to.title or gid
    if is_administrate(msg, gid) then
      _config.chats.managed[gid] = nil
      save_config()
      os.execute('rm -r data/' .. gid)
      reply_msg(msg.id, _('Group has been removed'), ok_cb, true)
    end
  end

  function get_config(msg, gid)
      local cfg_cp = './data/config.lua'
 --     os.execute('cp data/config.lua ' .. cfg_cp)
      td.sendDocument(get_receiver(msg), 0, 0, 1, nil, cfg_cp)
    end
	
  function get_backup(msg, gid)
    if gid then
--      local cfg_cp = '/tmp/..'
	  local cfg_cp = 'data/' .. gid .. '/' .. gid .. '.lua'
	  local x = load_data(_config.chats.managed[gid])
--	  local jx = json.encode(x)
--	  file = io.open(cfg_cp, 'w+')
 --     file:write(jx)
  --    file:close()
      td.sendDocument(get_receiver(msg), 0, 0, 1, nil, cfg_cp)
    end
  end
  -- Create a Group chat
  function cp_callback(extra,result)
  print('os cb')
    if log_error(result) then
      return
    end
    local gid = result.id_
    add_group(msg, gid, msg.from.peer_id)
    td.sendText(gid, 0, 1, 0, nil, _('UltraMax is now admin of group'), 0, nil, ok_cb, bk)

  end


  function create_group(msg, title, g_type)
    if not _config.mkgroup then
      _config.mkgroup = {founded = '', founder = '', title = '', gtype = '', uid = ''}
      save_config()
    end
    local rightnow = msg.date
    local last_time = tonumber(_config.mkgroup.founded) or 0
    if os.difftime(rightnow,last_time) > 3600 then
      local uname = msg.from.username or msg.from.first_name
      _config.mkgroup = {founded = rightnow, founder = uname, title = title, gtype = g_type, uid = msg.from.peer_id}
      save_config()
      -- td.createNewGroupChat({[0] = msg.from.id}, title,cp_callback,{user=msg.from.peer_id})


      reply_msg(msg.id, 'Group ' .. title .. ' has been created.', ok_cb, true)
    else
      reply_msg(msg.id, _('I limit myself to create a group per hours.\n'
      .. 'Please try again in next one hour.'), ok_cb, true)
    end
  end

  -- Global broadcasting
  function send_broadcast(msg, bc_msg)
    local data = _config.chats.managed
    for gid,v in pairs(data) do
      bc_rcvr = gid
      api.send_inline(bc_rcvr, bc_msg, {{{text='Our channel',url='https://t.me/MaxTeamCh'}}})
    end
  end

  function run(msg, matches)
    local gid = msg.to.peer_id
    local uid = msg.from.peer_id
    local chat_db = 'data/' .. gid .. '/' .. gid .. '.lua'
	local cmd = redis:hget('group:'..msg.to.id..':cmd', 'bot')
    local receiver = get_receiver(msg)
	   if cmd == 'mod' and not is_mod(msg, gid, uid) or cmd == 'owner' and not is_owner(msg, gid, uid) then
 return
 else
    if msg.to.type ~= 'user' then -- if in a chat group
    if is_sudo(uid) then
      if matches[1] == 'channel' then
        if matches[2] == 'enable' then
          if _config.chats.disabled[receiver] == nil then
            return reply_msg(msg.id, _('Group is not disable'), ok_cb, true)
          end
          _config.chats.disabled[receiver] = false
          save_config()
          return reply_msg(msg.id, _("Group is enabled now"), ok_cb, true)
        end
        if matches[2] == 'disable' then
          _config.chats.disabled[receiver] = true
          save_config()
          reply_msg(msg.id, _("bot is not working on the group new"), ok_cb, true)
        end
      end
      
      if matches[1] == 'visudo' or matches[1] == 'sudo' then

        if msg.reply_id then
          get_message(msg.reply_id, action_by_reply, msg)
        elseif matches[2] == '@' then
          resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
        elseif matches[3]:match('^%d+$') then
          visudo({msg=msg, usr=matches[3]}, matches[3])
        end
      end

      -- Demote a user from sudoer by {id|username|name|reply}
      if matches[1] == 'desudo' then
        if msg.reply_id then
          get_message(msg.reply_id, action_by_reply, msg)
        elseif matches[2] == '@' then
          resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
        elseif matches[3]:match('^%d+$') then
          desudo({msg=msg, usr=matches[3]}, matches[3])
        end
      end

      -- List of sudoers
      if matches[1] == 'sudolist' then
        get_sudolist(msg)
      end

      -- Promote user to be an admin by {id|username|name|reply}
      if matches[1] == 'adminprom' or matches[1] == 'admin' then
        if msg.reply_id then
          get_message(msg.reply_id, action_by_reply, msg)
        elseif matches[2] == '@' then
          resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
        elseif matches[3]:match('^%d+$') then
          promote_admin({msg=msg, usr=matches[3]}, matches[3])
        end
      end

      -- Demote user from admin by {id|username|name|reply}
      if matches[1] == 'admindem' or matches[1] == 'deadmin' then
        if msg.reply_id then
          get_message(msg.reply_id, action_by_reply, msg)
        elseif matches[2] == '@' then
          resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
        elseif matches[3]:match('^%d+$') then
          demote_admin({msg=msg, usr=matches[3]}, matches[3])
        end
      end

      -- Demote all administrators
      if matches[1] == 'clear' and matches[2] == 'admins' then
        del_adminlist(msg, gid)
      end

      -- Download 'data/config.lua'
      if msg.text:match('getconfig') then
        get_config(msg)
      end

      -- Create the realm
      if matches[2] == 'realm' then
        if not _config.realm then
          _config.realm = {}
          save_config()
        end
        if _config.realm[gid] then
          reply_msg(msg.id, lang.relm, ok_cb, true)
        else
          if matches[1] == 'mk' and matches[3] then
            n_realm = matches[3]
            create_group(msg, matches[3], 'realm')
          elseif matches[1] == 'add' then
            local cfg = 'data/' .. gid .. '/' .. gid .. '.lua'
            _config.realm = {[gid] = cfg, rgid = gid, rname = n_realm}
            save_config()
          end
          local bc_msg = lang.newr
          send_broadcast(msg, bc_msg)
        end
      end

      -- Delete the realm
      if matches[1] == 'removerealm' then
        if _config.realm[gid] then
          _config.realm = {}
          save_config()
          send_broadcast(msg, 'The realm has been deleted.')
        else
          reply_msg(msg.id, 'We have no realm at the moment.', ok_cb, true)
        end
      end

      -- Global broadcasting
      if matches[1] == 'broadcast' then
        send_broadcast(msg, matches[2])
      end
	  if matches[1] == 'mksupergroup' and matches[2] then
        create_group(msg, matches[2], 'channel')
      end
	  if matches[1] == 'mkgroup' and matches[2] then
        create_group(msg, matches[2], 'chat')
      end
    end
    
	if is_leader(msg, gid, uid) then
	     if matches[1] == 'setleader' or matches[1] == 'gl' then
        if msg.reply_id and not (matches[2]) then
          get_message(msg.reply_id, action_by_reply, msg)
        elseif matches[2] == '@' and matches[3] then
          resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
        elseif matches[2]:match('^%d+$') then
          promote_leader({msg=msg, usr=matches[2]}, gid, matches[2])
        end
      end
	   -- Set leader of a group
      if matches[1] == 'setowner' or matches[1] == 'gov' then
        if msg.reply_id and not matches[2]then
          get_message(msg.reply_id, action_by_reply, msg)
        elseif matches[2] == '@' then
          resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
        elseif matches[3]:match('^%d+$') then
          promote_owner({msg=msg, usr=matches[3]}, gid, matches[3])
        end
      end

      -- Remove owner of a group
      if matches[1] == 'remowner' or matches[1] == 'degov' then
        if msg.reply_id and not matches[2]then
          get_message(msg.reply_id, action_by_reply, msg)
        elseif matches[2] == '@' then
          resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
        elseif matches[3]:match('^%d+$') then
          demote_owner({msg=msg, usr=matches[3]}, gid, matches[3])
        end
      end
	  
	  end
    if is_admin(uid) then
      -- Create a Supergroup
      
      -- Add a group to be moderated. Note, this will automatically generate invite link.
      if matches[1] == 'addgroup' or matches[1] == 'gadd' then
        add_group(msg, gid, uid)
      end
      -- Remove group from administration
      if matches[1] == 'remgroup' or matches[1] == 'grem' or matches[1] == 'gremove' then
       return remove_group(msg, gid)
      end
      -- Promote a user to sudoer by {id|username|name|reply}

      -- Create a (normal) Group
      
    
	if matches[1] == 'setall' then
	td.getChannelMembers(gid, 0, 'Administrators', 20,config_admins,{msg=msg,gid=gid})
	end
 

      -- Lis of administrators
      if matches[1] == 'adminlist' then
        get_adminlist(msg, gid)
      end

      -- List of owners
      if matches[1] == 'clear' and matches[2] == 'owners' then
        del_ownerlist(msg, gid)
      end

      -- Globally ban user by {id|username|name|reply}
      if matches[1] == 'superban' or matches[1] == 'gban' or matches[1] == 'hammer' then
        if msg.reply_id and not matches[2]then
          get_message(msg.reply_id, action_by_reply, msg)
        elseif matches[2] == '@' then
          resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
        elseif matches[3]:match('^%d+$') then
          global_ban_user({msg=msg, usr=matches[3]}, gid, matches[3])
        end
      end

      -- Globally lift ban from user by {id|username|name|reply}
      if matches[1] == 'superunban' or matches[1] == 'gunban' or matches[1] == 'unhammer' then
        if msg.reply_id and not matches[2]then
          get_message(msg.reply_id, action_by_reply, msg)
        elseif matches[2] == '@' then
          resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
        elseif matches[3]:match('^%d+$') then
          global_unban_user({msg=msg, usr=matches[3]}, matches[3])
        end
      end

      -- Enable whitelist
      if matches[1] == 'whitelist' then
        if msg.reply_id and not matches[2]then
          get_message(msg.reply_id, action_by_reply, msg)
        elseif matches[2] == 'enable' then
          redis:set('whitelist:enabled', true)
          reply_msg(msg.id, 'Enabled whitelist', ok_cb, true)
        elseif matches[2] == 'disable' then
          redis:del('whitelist:enabled')
          reply_msg(msg.id, 'Disabled whitelist', ok_cb, true)
        elseif matches[2] == 'clear' then
          local hash =  'whitelist'
          redis:del(hash)
          return "Whitelist cleared."
        elseif matches[2] == 'chat' then
          redis:sadd('whitelist', gid)
          reply_msg(msg.id, 'Chat ' .. gid .. ' whitelisted', ok_cb, true)
        end
      end

      -- Remove user from whitelist by {id|username|name|reply}
      if matches[1] == 'unwhitelist' then
        if msg.reply_id and not matches[2]then
          get_message(msg.reply_id, action_by_reply, msg)
        elseif matches[2] == 'chat' then
          redis:srem('whitelist', gid)
          reply_msg(msg.id, 'Chat ' .. gid .. ' removed from whitelist', ok_cb, true)
        end
      end

      -- List of group's moderators
      if matches[1] == 'modlist' and matches[2] and matches[2]:match('^%d+$') then
        get_modlist(msg, matches[2])
      end

      -- Broadcasting
      if matches[1] == 'bc' then
        local gid = tonumber(matches[2])
        local data = load_data(_config.chats.managed[gid])
        local g_type = data.group_type
        send_large_msg(gid, matches[3])
      end

    end

    if not _config.chats.managed[gid] then
      return
    end
    local data = load_data(_config.chats.managed[gid])

    if is_owner(msg, gid, uid) then
	
      if matches[1] == 'setprivate' then
        data.public = false
        save_data(data, chat_db)
        reply_msg(msg.id, lang.public.nopublic, ok_cb, true)
      end

      if matches[1] == 'setpublic' then
        data.public = true
        save_data(data, chat_db)
        reply_msg(msg.id, lang.public.public, ok_cb, true)
      end
	  
	  if matches[1] == 'cmds' then 
	  if matches[2] == 'owner' then
	  redis:hset('group:'..msg.to.id..':cmd', 'bot', 'owner')
	  return 'cmds set for owner or higher'
	  end
	  if matches[2] == 'mod' then
	  redis:hset('group:'..msg.to.id..':cmd', 'bot', 'mod')
	  return 'cmds set for mod or higher'
	  end
	  if matches[2] == 'member' then
	  redis:del('group:'..msg.to.id..':cmd')
	  return 'cmds set for member or higher'
	  end
	  end
		

      if matches[1] == 'revoke' then
local text = _('*Done! Congratulations on your new group.\n'
..'Use this token to access the inline bot ;*\n`%s'
..'`\n\n*For a description of the Group Mangering , see this channel and read text of posts msg;* ')
        local alf = {'A','a','b','c','d','e','f','g','h','i','j','k','l','n','o','p','q','r','s','t','u','v','w','x','y','z','B','C','D','E','F','G','H','I','J','K','L','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}
        local token = tostring(gid):gsub('-100','')..':'
        for i=1,30 do
          token = token..''..alf[math.random(#alf)]..''
        end
        config.token[token] = gid
        data.token = token
        save_data(data, chat_db)
        save_config()
        return (text):format(token)

      end

      if matches[1] == 'token' then
        if data.token then
          local text = _('*This is your group token ;*\n\n'
	 ..'`%s`\n'
	 ..'*for revoke it send */revoke\n')
          return text:format(data.token)
        end
        local alf = {'A','a','b','c','d','e','f','g','h','i','j','k','l','n','o','p','q','r','s','t','u','v','w','x','y','z','B','C','D','E','F','G','H','I','J','K','L','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}
        local token = tostring(gid):gsub('-100','')..':'
        for i=1,30 do
          token = token..''..alf[math.random(#alf)]..''
        end
        config.token[token] = gid
        data.token = token
        save_data(data, chat_db)
        save_config()
        local text = _('Done! Congratulations on your new group.\nUse this token to access the inline bot :\n%s\n\nFor a description of the Group Mangering , see this channel and read text of posts msg: ')
        return text:format(token)
      end
      if matches[1] == 'warnmod' then  --warning settings
      if matches[2] == 'kick' then
        if data.warn_settings.action ~= 'kick' then
          data.warn_settings.action = 'kick'
          save_data(data, chat_db)
        end
        reply_msg(msg.id, 'Warning protection already enabled.\n'
        .. 'Offender will be kicked.', ok_cb, true)
      end
      if matches[2] == 'ban' then
        if data.warn_settings.action ~= 'ban' then
          data.warn_settings.action = 'ban'
          save_data(data, chat_db)
        end
        reply_msg(msg.id, 'Warning protection already enabled.\n'
        .. 'Offender will be banned.', ok_cb, true)
      end
      if matches[2] == 'disable' then
        if data.warn_settings.action == 'no' then
          reply_msg(msg.id, 'Warning protection is not enabled.', ok_cb, true)
        else
          data.warn_settings.action = 'no'
          save_data(data, chat_db)
          reply_msg(msg.id, 'Warning protection has been disabled.', ok_cb, true)
        end
      end
    end

    if matches[1] == 'warnmax' then  -- set max warn
    local number = tonumber(matches[2])

    if not number then --cheack warn
    return reply_msg(msg.id, 'Something was wrong\nwhat else are you thing?', ok_cb, true)
  end

  if number > 10 then --setup two
  return reply_msg(msg.id, 'Something was wrong\nnumber is too big', ok_cb, true)
elseif number <= 0 then
  return reply_msg(msg.id, 'Something was wrong\nnumber is too short', ok_cb, true)
end

data.warn_settings.max_warn = math.floor(number)
save_data(data, chat_db)
return reply_msg(msg.id, 'done\nmax warn seted to :'..data.warn_settings.max_warn, ok_cb, true)
end -- end warnmax

if matches[1] == ('filters' or 'filterlist') then -- get filtelist
if not next(data.filters) then
  return reply_msg(msg.id, 'no filters word in the group', ok_cb, true)
end
local text = 'List of filters word list : \n'
for k,v in pairs(data.filters) do
  text = text..'*-*'..k..' : '..v..'\n'
end
reply_msg(msg.id, text, ok_cb, true)
end

if matches[1] == 'filter' then -- fiter list
local type = matches[3]
local type = type:match('ban') or type:match('kick') or type:match('warn') or type:match('del')
if not type then
return reply_msg(msg.id, 'Filter type is none', ok_cb, true)
end
local text_len = string.len(matches[2])

if text_len > 100 then
return reply_msg(msg.id, 'filter match is too big', ok_cb, true)
end

if data.filters[matches[2]] then
return reply_msg(msg.id, 'is already on filters', ok_cb, true)
end
data.filters[matches[2]] = type
save_data(data, chat_db)
local text = '%s has been added to filterlist'
return reply_msg(msg.id, text:format(matches[2]), ok_cb, true)
end

if matches[1] == 'unfilter' then
if data.filters[matches[2]] then
data.filters[matches[2]] = nil
save_data(data, chat_db)
local text = '%s has been removed from filterlist'
return reply_msg(msg.id, text:format(matches[2]), ok_cb, true)
end
local text = '%s is not in the filterlist'
return reply_msg(msg.id, text:format(matches[2]), ok_cb, true)
end
-- Anti spam and flood settings
if matches[1] == 'antispam' then
if matches[2] == 'kick' then
if data.antispam.action ~= 'kick' then
  data.antispam.action = 'kick'
  save_data(data, chat_db)
end
reply_msg(msg.id, 'Anti spam protection already enabled.\n'
.. 'Offender will be kicked.', ok_cb, true)
end
if matches[2] == 'ban' then
if data.antispam.action ~= 'ban' then
  data.antispam.action = 'ban'
  save_data(data, chat_db)
end
reply_msg(msg.id, 'Anti spam protection already enabled.\n'
.. 'Offender will be banned.', ok_cb, true)
end
if matches[2] == 'disable' then
if data.antispam.action == 'no' then
  reply_msg(msg.id, 'Anti spam protection is not enabled.', ok_cb, true)
else
  data.antispam.action = 'no'
  save_data(data, chat_db)
  reply_msg(msg.id, 'Anti spam protection has been disabled.', ok_cb, true)
end
end
end

-- Allow user by {is|name|username|reply} to use the bot when whitelist is enabled.
if matches[1] == 'whitelist' then
if msg.reply_id and not matches[2]then
get_message(msg.reply_id, action_by_reply, msg)
elseif matches[2] == '@' then
resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
elseif matches[3] and matches[3]:match('^%d+$') then
whitelisting({msg=msg, usr=matches[3]}, matches[3])
end
end

if matches[1] == 'warn' then
if msg.reply_id and not matches[2]then
print(msg.reply_id)
get_message(msg.reply_id, action_by_reply, msg)
elseif matches[2] == '@' then
resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
elseif matches[2] and matches[2]:match('^%d+$') then
warn({msg=msg, usr=matches[2]}, gid,matches[2])
end
end

if matches[1] == 'unwarn' then
if msg.reply_id and not matches[2]then
get_message(msg.reply_id, action_by_reply, msg)
elseif matches[2] == '@' then
resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
elseif matches[2] and matches[2]:match('^%d+$') then
unwarn({msg=msg, usr=matches[2]}, gid,matches[2])
end
end

if matches[1] == 'warnlist' then -- list of warn user list
if not next(data.warn_counter) then
return reply_msg(msg.id, 'no warn user list', ok_cb, true)
end
local text = 'List of warn user list : \n'
for k,v in pairs(data.warn_counter) do
text = text..'*-*'..k..' ; '..v..'\n'
end
reply_msg(msg.id, text, ok_cb, true)
end

-- Remove users permission by {is|name|username|reply} to use the bot when whitelist is enabled.
if matches[1] == 'unwhitelist' then
if msg.reply_id and not matches[2]then
get_message(msg.reply_id, action_by_reply, msg)
elseif matches[2] == '@' then
resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
elseif matches[3]:match('^%d+$') then
unwhitelisting({msg=msg, usr=matches[3]}, matches[3])
end
end

-- Invite link. Users could join the group by clicking this link.
if matches[1] == 'setlink' or matches[1] == 'link set' then
if matches[2] then
local bk = msg.text:match('setlink (.*)')  or msg.text:match('link set (.*)') 
data.link = bk
save_data(data, chat_db)
api.sendMessage(msg.to.id, '['..data.link..']', 'html', nil, nil, true)
else
set_group_link({msg=msg, gid=gid}, chat_db)
end
end

-- Revoke group's invite link to make the group private
if matches[1] == 'link revoke' then
if data.link == '' then
reply_msg(msg.id, "This group doesn't have invite link", ok_cb, true)
else
set_group_link({msg=msg, gid=gid}, chat_db, 'revoke')
reply_msg(msg.id, 'Invite link has been revoked', ok_cb, true)
end
end

if matches[1] == 'clear' and matches[2] == 'bots' then -- clean bots
td.getChannelMembers(gid, 0, 'Bots', 200, clean_bots, {gid=gid})
end

if matches[1] == 'group' and matches[2] == 'bots' then
td.getChannelMembers(msg.to.id, 0, 'Bots', 200, mem, {model = 'bot'})
end

if matches[1] == 'group' and matches[2] == 'kicked' then
td.getChannelMembers(msg.to.id, 0, 'Kicked', 200, mem, {model = 'kick'})
end

if matches[1] == 'group' and matches[2] == 'admins' then
td.getChannelMembers(msg.to.id, 0, 'Administrators', 200, mem, {model = 'admin', txt = text})
end

if matches[1] == 'group' and matches[2] == 'members' then 
td.getChannelMembers(msg.to.id, 0, 'Recent', 200, mem, {model = 'all'})
end

if matches[1] == 'clear' and matches[2] == 'msg' then
td.getChatHistory(gid, 0, 0, 1000,clean_msg,{gid=gid})
td.getChatHistory(gid, 0, 0, 1000,clean_msg,{gid=gid})
td.getChatHistory(gid, 0, 0, 1000,clean_msg,{gid=gid})
td.getChatHistory(gid, 0, 0, 1000,clean_msg,{gid=gid})
td.getChatHistory(gid, 0, 0, 1000,clean_msg,{gid=gid})
reply_msg(msg.id, 'msgs Has Been Deleted', ok_cb, true)
end
if matches[1] == 'clear' and matches[2] == 'member' then -- clean member
td.getChannelMembers(gid, 0, 'Recent', 400, clean_bots, {gid=gid})
return 'done'

end
-- Set group's name/title

if matches[1] == 'setname' then
data.name = matches[2]
save_data(data, chat_db)
if msg.to.peer_type == 'channel' then
rename_channel(receiver, data.name, ok_cb, true)
else
rename_chat(receiver, data.name, ok_cb, true)
end
end



-- Sticker settings
if matches[1] == 'sticker' then
if matches[2] == 'del' then
if data.lock.sticker ~= 'del' then
data.lock.sticker = 'del'
save_data(data, chat_db)
end
reply_msg(msg.id, 'This group does not allow sticker script.\n'
.. 'Users will msgs well be deleted', ok_cb, true)
end
if matches[2] == 'warn' then
if data.lock.sticker ~= 'warn' then
data.lock.sticker = 'warn'
save_data(data, chat_db)
end
reply_msg(msg.id, 'Stickers already prohibited.\n'
.. 'Sender will be warned first, then kicked for second violation.', ok_cb, true)
end
if matches[2] == 'kick' then
if data.lock.sticker ~= 'kick' then
data.lock.sticker = 'kick'
save_data(data, chat_db)
end
reply_msg(msg.id, 'Stickers already prohibited.\n'
.. 'Sender will be kicked!', ok_cb, true)
end
if matches[2] == 'ok' then
if data.lock.sticker == 'ok' then
reply_msg(msg.id, 'Sticker restriction is not enabled.', ok_cb, true)
else
data.lock.sticker = 'ok'
save_data(data, chat_db)
for k,sticker_hash in pairs(redis:keys('mer_sticker:' .. gid .. ':*')) do
redis:del(sticker_hash)
end
reply_msg(msg.id, 'Sticker restriction has been disabled.\n'
.. 'Previous infringements record has been cleared.', ok_cb, true)
end
end
end

-- Arabic settings
if matches[1] == 'arabic' then
if matches[2] == 'del' then
if data.lock.arabic ~= 'del' then
data.lock.arabic = 'del'
save_data(data, chat_db)
end
reply_msg(msg.id, 'This group does not allow Arabic script.\n'
.. 'Users will msgs well be deleted', ok_cb, true)
end
if matches[2] == 'warn' then
if data.lock.arabic ~= 'warn' then
data.lock.arabic = 'warn'
save_data(data, chat_db)
end
reply_msg(msg.id, 'This group does not allow Arabic script.\n'
.. 'Users will be warned first, then kicked for second infringements.', ok_cb, true)
end
if matches[2] == 'kick' then
if data.lock.arabic ~= 'kick' then
data.lock.arabic = 'kick'
save_data(data, chat_db)
end
reply_msg(msg.id, 'Users will now be removed automatically for posting Arabic script.', ok_cb, true)
end
if matches[2] == 'ok' then
if data.lock.arabic == 'ok' then
reply_msg(msg.id, 'Arabic posting restriction is not enabled.', ok_cb, true)
else
data.lock.arabic = 'ok'
save_data(data, chat_db)
redis:del('mer_arabic')
--              for k,arabic_hash in pairs(redis:keys('mer_arabic:' .. gid .. ':*')) do
--                redis:del(arabic_hash)
--              end
reply_msg(msg.id, 'Users will no longer be removed for posting Arabic script.', ok_cb, true)
end
end
end

if matches[1] == 'links' then
if matches[2] == 'del' then
if data.lock.links ~= 'del' then
data.lock.links = 'del'
save_data(data, chat_db)
end
reply_msg(msg.id, 'This group does not allow links script.\n'
.. 'Users will msgs well be deleted', ok_cb, true)
end
if matches[2] == 'warn' then
if data.lock.links ~= 'warn' then
data.lock.links = 'warn'
save_data(data, chat_db)
end
reply_msg(msg.id, 'This group does not allow links script.\n'
.. 'Users will be warned first, then kicked for second infringements.', ok_cb, true)
end
if matches[2] == 'kick' then
if data.lock.links ~= 'kick' then
data.lock.links = 'kick'
save_data(data, chat_db)
end
reply_msg(msg.id, 'Users will now be removed automatically for posting links script.', ok_cb, true)
end
if matches[2] == 'ok' then
if data.lock.links == 'ok' then
reply_msg(msg.id, 'links posting restriction is not enabled.', ok_cb, true)
else
data.lock.links = 'ok'
save_data(data, chat_db)
redis:del('mer_links')
for k,links_hash in pairs(redis:keys('mer_links:' .. gid .. ':*')) do
redis:del(links_hash)
            end
reply_msg(msg.id, 'Users will no longer be removed for posting links script.', ok_cb, true)
end
end
end
if matches[1] == 'photo' then
if matches[2] == 'warn' then
if data.lock.photo ~= 'warn' then
data.lock.photo = 'warn'
save_data(data, chat_db)
end
reply_msg(msg.id, 'This group does not allow photo script.\n'
.. 'Users will be warned first, then kicked for second infringements.', ok_cb, true)
end
if matches[2] == 'kick' then
if data.lock.photo ~= 'kick' then
data.lock.photo = 'kick'
save_data(data, chat_db)
end
reply_msg(msg.id, 'Users will now be removed automatically for posting photo script.', ok_cb, true)
end
if matches[2] == 'ok' then
if data.lock.photo == 'ok' then
reply_msg(msg.id, 'photo posting restriction is not enabled.', ok_cb, true)
else
data.lock.photo = 'ok'
save_data(data, chat_db)
redis:del('mer_photo')
for k,photo_hash in pairs(redis:keys('mer_photo:' .. gid .. ':*')) do
  redis:del(photo_hash)
end
reply_msg(msg.id, 'Users will no longer be removed for posting photo script.', ok_cb, true)
end
end
end
if matches[1] == 'video' then
if matches[2] == 'warn' then
if data.lock.video ~= 'warn' then
data.lock.video = 'warn'
save_data(data, chat_db)
end
reply_msg(msg.id, 'This group does not allow video script.\n'
.. 'Users will be warned first, then kicked for second infringements.', ok_cb, true)
end
if matches[2] == 'kick' then
if data.lock.video ~= 'kick' then
data.lock.video = 'kick'
save_data(data, chat_db)
end
reply_msg(msg.id, 'Users will now be removed automatically for posting video script.', ok_cb, true)
end
if matches[2] == 'ok' then
if data.lock.video == 'ok' then
reply_msg(msg.id, 'video posting restriction is not enabled.', ok_cb, true)
else
data.lock.video = 'ok'
save_data(data, chat_db)
redis:del('mer_video')
--              for k,video_hash in pairs(redis:keys('mer_video:' .. gid .. ':*')) do
  --                redis:del(video_hash)
  --              end
  reply_msg(msg.id, 'Users will no longer be removed for posting video script.', ok_cb, true)
end
end
end
if matches[1] == 'gif' then
if matches[2] == 'warn' then
if data.lock.gif ~= 'warn' then
  data.lock.gif = 'warn'
  save_data(data, chat_db)
end
reply_msg(msg.id, 'This group does not allow gif script.\n'
.. 'Users will be warned first, then kicked for second infringements.', ok_cb, true)
end
if matches[2] == 'kick' then
if data.lock.gif ~= 'kick' then
  data.lock.gif = 'kick'
  save_data(data, chat_db)
end
reply_msg(msg.id, 'Users will now be removed automatically for posting gif script.', ok_cb, true)
end
if matches[2] == 'ok' then
if data.lock.gif == 'ok' then
  reply_msg(msg.id, 'gif posting restriction is not enabled.', ok_cb, true)
else
  data.lock.gif = 'ok'
  save_data(data, chat_db)
  redis:del('mer_gif')
  --              for k,gif_hash in pairs(redis:keys('mer_gif:' .. gid .. ':*')) do
    --                redis:del(gif_hash)
    --              end
    reply_msg(msg.id, 'Users will no longer be removed for posting gif script.', ok_cb, true)
  end
end
end
if matches[1] == 'fwd' then
if matches[2] == 'warn' then
  if data.lock.fwd ~= 'warn' then
    data.lock.fwd = 'warn'
    save_data(data, chat_db)
  end
  reply_msg(msg.id, 'This group does not allow fwd script.\n'
  .. 'Users will be warned first, then kicked for second infringements.', ok_cb, true)
end
if matches[2] == 'kick' then
  if data.lock.fwd ~= 'kick' then
    data.lock.fwd = 'kick'
    save_data(data, chat_db)
  end
  reply_msg(msg.id, 'Users will now be removed automatically for posting fwd script.', ok_cb, true)
end
if matches[2] == 'ok' then
  if data.lock.fwd == 'ok' then
    reply_msg(msg.id, 'fwd posting restriction is not enabled.', ok_cb, true)
  else
    data.lock.fwd = 'ok'
    save_data(data, chat_db)
    redis:del('mer_fwd')
    --              for k,fwd_hash in pairs(redis:keys('mer_fwd:' .. gid .. ':*')) do
      --                redis:del(fwd_hash)
      --              end
      reply_msg(msg.id, 'Users will no longer be removed for posting fwd script.', ok_cb, true)
    end
  end
end
if matches[1] == 'reply' then
  if matches[2] == 'warn' then
    if data.lock.Reply ~= 'warn' then
      data.lock.Reply = 'warn'
      save_data(data, chat_db)
    end
    reply_msg(msg.id, 'This group does not allow Reply script.\n'
    .. 'Users will be warned first, then kicked for second infringements.', ok_cb, true)
  end
  if matches[2] == 'kick' then
    if data.lock.Reply ~= 'kick' then
      data.lock.Reply = 'kick'
      save_data(data, chat_db)
    end
    reply_msg(msg.id, 'Users will now be removed automatically for posting Reply script.', ok_cb, true)
  end
  if matches[2] == 'ok' then
    if data.lock.Reply == 'ok' then
      reply_msg(msg.id, 'Reply posting restriction is not enabled.', ok_cb, true)
    else
      data.lock.Reply = 'ok'
      save_data(data, chat_db)
      redis:del('mer_Reply')
      for k,Reply_hash in pairs(redis:keys('mer_Reply:' .. gid .. ':*')) do
        redis:del(Reply_hash)
      end
      reply_msg(msg.id, 'Users will no longer be removed for posting Reply script.', ok_cb, true)
    end
  end
end
-- Set custom welcome message
if matches[1] == 'setwelcome' and matches[2] then
  data.welcome.msg = matches[2]
  save_data(data, chat_db)
  reply_msg(msg.id, 'Set group welcome message to:\n' .. matches[2], ok_cb, true)
end

-- Reset custom welcome message
if matches[1] == 'resetwelcome' then
  data.welcome.msg = nil
  save_data(data, chat_db)
  reply_msg(msg.id, 'Welcome message has been reset.', ok_cb, true)
end

-- Welcome message settings
if matches[1] == 'welcome' then
  if matches[2] == 'group' and data.welcome.to ~= 'group' then
    data.welcome.to = 'group'
    save_data(data, chat_db)
    reply_msg(msg.id, 'Welcome service already enabled.\n'
    .. 'Welcome message will shown in group.', ok_cb, true)
  end
  if matches[2] == 'pm' and data.welcome.to ~= 'private' then
    data.welcome.to = 'private'
    save_data(data, chat_db)
    reply_msg(msg.id, 'Welcome service already enabled.\n'
    .. 'Welcome message will send as private message to new member.', ok_cb, true)
  end
  if matches[2] == 'disable' then
    if data.welcome.to == 'no' then
      reply_msg(msg.id, 'Welcome service is not enabled.', ok_cb, true)
    else
      data.welcome.to = 'no'
      save_data(data, chat_db)
      reply_msg(msg.id, 'Welcome service has been disabled.', ok_cb, true)
    end
  end
end

-- Set group's description
if matches[1] == 'setabout' and matches[2] then
  data.description = matches[2]
  save_data(data, chat_db)
  reply_msg(msg.id, 'Set group description to:\n' .. matches[2], ok_cb, true)
end

-- Set group's rules
if matches[1] == 'setrules' and matches[2] then
  data.rules = matches[2]
  save_data(data, chat_db)
  reply_msg(msg.id, 'Set group rules to:\n' .. matches[2], ok_cb, true)
end

if matches[1] == 'group' or matches[1] == 'gp' then
  -- Lock {bot|name|member|photo|sticker}
  if matches[2] == 'lock' then
    if matches[3] == 'bot' then
      if data.lock.bot == 'yes' then
        reply_msg(msg.id, 'Group is already locked from bots.', ok_cb, true)
      else
        data.lock.bot = 'yes'
        save_data(data, chat_db)
        reply_msg(msg.id, 'Group is locked from bots.', ok_cb, true)
      end
    end
    if matches[3] == 'all' then
      if data.lock.all == 'yes' then
        reply_msg(msg.id, 'Group is already locked from all msgs.', ok_cb, true)
      else
        data.lock.all = 'yes'
        save_data(data, chat_db)
        reply_msg(msg.id, 'Group is locked from all msgs.', ok_cb, true)
      end
    end
    if matches[3] == 'name' then
      if data.lock.name == 'yes' then
        reply_msg(msg.id, 'Group name is already locked', ok_cb, true)
      else
        data.lock.name = 'yes'
        save_data(data, chat_db)
        data.set.name = msg.to.title
        save_data(data, chat_db)
        reply_msg(msg.id, 'Group name has been locked', ok_cb, true)
      end
    end
    if matches[3] == 'member' then
      if data.lock.member == 'yes' then
        reply_msg(msg.id, 'Group members are already locked', ok_cb, true)
      else
        data.lock.member = 'yes'
        save_data(data, chat_db)
      end
      reply_msg(msg.id, 'Group members has been locked', ok_cb, true)
    end
    if matches[3] == 'photo' then
      if data.lock.photo == 'yes' then
        reply_msg(msg.id, 'Group photo is already locked', ok_cb, true)
      else
        data.set.photo = 'waiting'
        save_data(data, chat_db)
      end
      reply_msg(msg.id, 'Please send me the group photo now', ok_cb, true)
    end
  end
  -- Unlock {bot|name|member|photo|sticker}
  if matches[2] == 'unlock' then
    if matches[3] == 'bot' then
      if data.lock.bot == 'no' then
        reply_msg(msg.id, 'Bots are allowed to enter group.', ok_cb, true)
      else
        data.lock.bot = 'no'
        save_data(data, chat_db)
        reply_msg(msg.id, 'Group is open for bots.', ok_cb, true)
      end
    end
    if matches[3] == 'all' then
      if data.lock.all == 'no' then
        reply_msg(msg.id, 'mute all msg is already unlocked', ok_cb, true)
      else
        data.lock.all = 'no'
        save_data(data, chat_db)
        reply_msg(msg.id, 'Group silent has been unlocked', ok_cb, true)
      end
    end
    if matches[3] == 'name' then
      if data.lock.name == 'no' then
        reply_msg(msg.id, 'Group name is already unlocked', ok_cb, true)
      else
        data.lock.name = 'no'
        save_data(data, chat_db)
        reply_msg(msg.id, 'Group name has been unlocked', ok_cb, true)
      end
    end
    if matches[3] == 'member' then
      if data.lock.member == 'no' then
        reply_msg(msg.id, 'Group members are not locked', ok_cb, true)
      else
        data.lock.member = 'no'
        save_data(data, chat_db)
        reply_msg(msg.id, 'Group members has been unlocked', ok_cb, true)
      end
    end
    if matches[3] == 'photo' then
      if data.lock.photo == 'no' then
        reply_msg(msg.id, 'Group photo is not locked', ok_cb, true)
      else
        data.lock.photo = 'no'
        save_data(data, chat_db)
        reply_msg(msg.id, 'Group photo has been unlocked', ok_cb, true)
      end
    end
  end
end

-- List of globally banned users
if matches[1] == 'superbanlist' or matches[1] == 'gbanlist' or matches[1] == 'hammerlist' then
  local hash = 'globanned'
  local list = redis:smembers(hash)
  local gbanlist = ''
  for k,v in pairs(list) do
    gbanlist = gbanlist .. k .. " - " .. v .. "\n"
  end
  if gbanlist == '' then
    gbanlist = 'There are currently no globally banned users.'
  else
    gbanlist = 'Globally banned users list:\n\n' .. gbanlist
  end
  return gbanlist
end

-- Promote group moderator
if matches[1] == 'promote' or matches[1] == 'mod' then
  if msg.reply_id and not matches[2]then
    get_message(msg.reply_id, action_by_reply, msg)
  elseif matches[2] == '@' then
    resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
  elseif matches[3]:match('^%d+$') then
    promote({msg=msg, usr=matches[3]}, gid, matches[3])
  end
end

-- Demote group moderator
if matches[1] == 'demote' or matches[1] == 'demod' then
  if msg.reply_id and not matches[2]then
    get_message(msg.reply_id, action_by_reply, msg)
  elseif matches[2] == '@' then
    resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
  elseif matches[3]:match('^%d+$') then
    demote({msg=msg, usr=matches[3]}, gid, matches[3])
  end
end

-- Demote all moderators
if matches[1] == 'clear' and matches[2] == 'mods' then
  del_modlist(msg, gid)
end

-- Download group configuration file.
if matches[1] == 'backup'  then
  get_backup(msg, gid)
end
end

if is_mod(msg, gid, uid) then
-- Print group settings
if (matches[1] == 'group' and matches[2] == 'settings') or (matches[1]== 'settings') or (matches[1] == 'gp' and matches[2] == 'settings') then
  local text = {}   -- os table
  local now = os.date('%j')
  local expire = data.expiretime or now
  local time = os.difftime(tonumber(expire),now)
  local title = ('*Settings for %s :*'):format(msg.to.id)
  table.insert(text, title)
  table.insert(text, 'Lock : ')
  for k,v in pairs(data.lock) do
    matn = '*-* *%s '..k..'* : `'..v..'`'
    table.insert(text, matn:format('Lock'))
  end
  table.insert(text, 'Welcome settings : ')
  for b,k in pairs(data.welcome) do
    matn = '*-* *Welcome '..b..'* : `'..k..'`'
    table.insert(text, matn)
  end
  table.insert(text, 'Anti spam Seetings : ')
  for x,y in pairs(data.antispam) do
    matn = '*-* *%s '..x..'* : `'..y..'`'
    table.insert(text, matn:format('spam'))
  end
  table.insert(text, 'Warn Settings : ')
  for x,y in pairs(data.warn_settings) do
    matn = '*-* *%s '..x..'* : `'..y..'`'
    table.insert(text, matn:format('Warn'))
  end
   table.insert(text, 'More Settings : ')
    matn = '*-* *bot expire time :* `'..math:source(time)..'`'
    table.insert(text, matn)
  return _(table.concat(text, '\n'))
end 



-- Kick user by {id|username|name|reply}
if matches[1] == 'kick' then
  if msg.reply_id and not matches[2]then
    get_message(msg.reply_id, action_by_reply, msg)
  elseif matches[2] == '@' then
    resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
  elseif matches[3]:match('^%d+$') then
    kick_user(msg, gid, matches[3])
  end
end

-- Kick user by {id|username|name|reply} and re-kick if rejoin
if matches[1] == 'ban' then
  if msg.reply_id and not matches[2]then
    get_message(msg.reply_id, action_by_reply, msg)
  elseif matches[2] == '@' then
    resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
  elseif matches[3] and matches[3]:match('^%d+$') then
    ban_user({msg=msg, usr=matches[3]}, gid, matches[3])
  end
end

-- Lift ban by {id|username|name|reply}
if matches[1] == 'unban' then
  if msg.reply_id and not matches[2]then
    get_message(msg.reply_id, action_by_reply, msg)
  elseif matches[2] == '@' then
    resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
  elseif matches[3]:match('^%d+$') then
    unban_user({msg=msg, usr=matches[3]}, gid, matches[3])
  end
end

-- List of group's banned users
if matches[1] == 'banlist' then
  local hash = 'banned:' .. gid
  local list = redis:smembers(hash)
  local banlist = ''
  for k,v in pairs(list) do
    banlist = banlist .. k .. " - " .. v .. "\n"
  end
  if banlist == '' then
    banlist = 'There are currently no banned users.'
  else
    banlist = 'Banned users list:\n\n' .. banlist
  end
  return banlist
end

-- List of group's moderators
if matches[1] == 'modlist' and is_administrate(msg, gid) then
  get_modlist(msg, gid)
end
end

if matches[1] == 'gllist' then
if data.leader then
  reply_msg(msg.id, _('Group leader : %s.'):format(get_uname(data.leader)), ok_cb, true)
else
return 'no leader for this group'
end
end
-- Kick per user's request. Don't do this in supergroup, because that's mean ban
if matches[1] == 'kickme' or matches[1] == 'leave' then
if msg.to.peer_type == 'channel' then
  reply_msg(msg.id, _('Leave this group manually or you will be unable to rejoin.'), ok_cb, true)
else
  kick_user(msg, gid, uid)
end
end

-- Print group's invite link. Users can join group by clicking this link.
if matches[1] == 'link' or matches[1] == 'getlink' or matches[1] == 'link get' then
local link = data.link
local gtitle = data.title or 'group link :'
if data.public or is_owner(msg, gid, uid) then
  if link == '' or not link then
	api.sendMessage(msg.to.id, 'No link has been set for this group.\n'
    .. 'Try `!link set` to generate.', true, nil, nil, true)
  elseif link == 'revoked' then
    reply_msg(msg.id, 'Invite link for this group has been revoked', ok_cb, true)
  else
    local about = data.description
    local clickme = '[click me to join group](' .. link .. ')'
    if not about then
    api.sendMessage(msg.to.id, '*' .. gtitle .. '*\n\n' .. clickme, true, nil, nil, true)
	else
       api.sendMessage(msg.to.id, '*' .. gtitle .. '*\n\n' .. about .. '\n\n' .. clickme, true, nil, nil, true)

   end
  end
else
  reply_msg(msg.id, 'This group is private.', ok_cb, true)
end
end

-- Print group's description.
if matches[1] == 'about' then
local about = data.description
local gtitle = data.title or 'group about :'
if not about then
  reply_msg(msg.id, _('No description available.'), ok_cb, true)
else
  api.sendMessage(get_receiver_api(msg), '<i>' .. about ..'</i>', 'html', true, false, msg.id)
--  api.sendMessage(get_receiver_api(msg), '<b>' .. gtitle .. '</b>\n\n' .. about, 'html', true, false, msg.id)
end
end

-- Print group's rules
if matches[1] == 'rules' then
local gtitle = data.title or gid
if not data.rules then
  --reply_msg(msg.id, 'No rules have been set for ' .. gtitle .. '.', ok_cb, true)
  reply_msg(msg.id, 'No rules have been set for ' .. gid .. '.', ok_cb, true)
else
  local rules = data.rules
  local rules = ' rules:\n\n' .. rules
  reply_msg(msg.id, rules, ok_cb, true)
end
end

-- List of groups managed by this bot (listed in data/config.lua)
if matches[1] == 'grouplist' or matches[1] == 'groups' or matches[1] == 'glist' then
local gplist = ''
for k,v in pairs(_config.chats.managed) do
  local gpdata = load_data(v)
  if gpdata.public then
    if gpdata.link then
      gplist = gplist .. '[' .. '#nil name' .. '](' .. (gpdata.link or 'not found') .. ')\n'
    else
      gplist = gplist .. '' .. '#nil name' .. '\n'
    end
  end
end 
if gplist == '' then
  gplist = 'There are currently no listed groups.'
else
  gplist = '*Groups:*\n' .. gplist
end
sleep(2)
td.sendText(msg.to.id, msg.id, 1, 0, nil, gplist, 0, nil, ok_cb, bk)
end

-- print nfs version
if matches[1] == "version" then
reply_msg(msg.id, 'nfs-bot\n' .. VERSION .. '\nGitHub: ' .. bot_repo .. '\n'
.. 'License: GNU GPL v2', ok_cb, true)
end

      if matches[1] == 'ownerlist' then
        get_ownerlist(msg, gid)
      end
	  
else -- if in private message

local usr = get_username(msg)

if is_sudo(uid) then
--TODO update_members_list an set_group_link not working in private message
--        if matches[1] == 'addgroup' or matches[1] == 'gadd' then
  --          add_groupadd_group(msg, matches[2], uid)
  --        end

  if matches[1] == 'remgroup' or matches[1] == 'grem' or matches[1] == 'gremove' then
    remove_group(msg, matches[2])
  end

  if matches[1] == 'adminprom' or matches[1] == 'admin' then
    if matches[2] == '@' then
      resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
    elseif matches[3]:match('^%d+$') then
      promote_admin({msg=msg, usr=usr}, matches[4])
    end
  end

  if matches[1] == 'admindem' or matches[1] == 'deadmin' then
    if matches[2] == '@' then
      resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
    elseif matches[3]:match('^%d+$') then
      demote_admin({msg=msg, usr=usr}, matches[4])
    end
  end
end

if is_leader(msg, gid, uid) then
  if matches[1] == 'setowner' or matches[1] == 'gov' then
    if matches[2] == '@' then
      resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
    elseif matches[3]:match('^%d+$') then
      promote_owner({msg=msg, usr=usr}, matches[4], matches[3])
    end
  end

  if matches[1] == 'remowner' or matches[1] == 'degov' then
    if matches[2] == '@' then
      resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
    elseif matches[3]:match('^%d+$') then
      demote_owner({msg=msg, usr=usr}, matches[4], matches[3])
    end
  end

  if matches[1] == 'promote' or matches[1] == 'mod' then
    if matches[2] == '@' then
      resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
    elseif matches[3]:match('^%d+$') then
      promote_owner({msg=msg, usr=usr}, matches[4], matches[3])
    end
  end

  if matches[1] == 'demote' or matches[1] == 'demod' then
    if matches[2] == '@' then
      resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
    elseif matches[3]:match('^%d+$') then
      demote_owner({msg=msg, usr=usr}, matches[4], matches[3])
    end
  end

  if matches[1] == 'ownerlist' then
    get_ownerlist(msg, matches[2])
  end
  end
if is_admin(uid) then
  if matches[1] == 'superban' or matches[1] == 'gban' or matches[1] == 'hammer' then
    if matches[2] == '@' then
      resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
    elseif matches[3]:match('^%d+$') then
      global_ban_user({msg=msg, usr=usr}, gid, matches[3])
    end
  end

  if matches[1] == 'superunban' or matches[1] == 'gunban' or matches[1] == 'unhammer' then
    if matches[2] == '@' then
      resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
    elseif matches[3]:match('^%d+$') then
      global_unban_user({msg=msg, usr=usr}, matches[3])
    end
  end

  if matches[1] == 'whitelist' then
    if matches[2] == 'chat' then
      redis:sadd('whitelist', matches[3])
      reply_msg(msg.id, 'Chat ' .. matches[3] .. ' whitelisted', ok_cb, true)
    end
  end

  if matches[1] == 'unwhitelist' then
    if matches[2] == 'chat' then
      redis:srem('whitelist', matches[3])
      reply_msg(msg.id, 'Chat ' .. matches[3] .. ' removed from whitelist', ok_cb, true)
    end
  end

  if matches[1] == 'kick' then
    if matches[2] == '@' then
      resolve_username(matches[3], resolve_username_cb, {msg=msg, matches=matches})
    elseif matches[3]:match('^%d+$') then
      kick_user(msg, matches[4], matches[3])
    end
  end
end
end
end
end

plugins['run'] = run
plugins['description'] = 'Administration plugin.'
plugins['patterns'] = triggers
plugins['usage'] = {'*send : *`[/!#]gpmod`'}
return plugins
end
