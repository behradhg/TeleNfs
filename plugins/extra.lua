function getExtraList(chat_id)
	local hash = 'chat:'..chat_id..':extra'
	local commands = redis:hkeys(hash)
	if not next(commands) then
		return _("No commands set")
	else
		local lines = {}
		for i, k in ipairs(commands) do
			table.insert(lines, (k:escape(true)))
		end
		return _("List of *custom commands*:\n") .. table.concat(lines, '\n')
	end
end

function clean_list(chat_id)
	local hash = 'chat:'..chat_id..':extra'
	local commands = redis:hkeys(hash)
	if not next(commands) then
		return _("No commands set")
	else
		for i, k in ipairs(commands) do
			redis:hdel(hash, k)
		end
		return _('all commands has been removed')
	end
end


function run(msg, matches)
	if msg.to.type == 'user' then return 'plugins doesnt work on user chat'end
	if not matches[3] and matches[1] == '-' then
	    local hash = 'chat:'..msg.to.id..':extra'
	    local success = redis:hdel(hash, matches[2])
	    if success == 1 then
	    	local out = _("The command '%s' has been deleted!"):format(matches[2])
	        return out
	    else
	        local out = _("The command '%s' does not exist!"):format(matches[2])
	        return out
	    end
end
	if matches[1] == 'extra' then
		if matches[2] ~= '-' and matches[3] then
	    	local hash = 'chat:'..msg.to.id..':extra'
	    	local new_extra = matches[3]	    	
	    	redis:hset(hash, matches[2], new_extra)
			return _("Command '%s' saved!"):format(matches[2])
			end
	end
	if matches[1] == 'extra list' then
		local text = getExtraList(msg.to.id)
	    return text
	end
    
	if matches[1] == 'clean' then
	
	return 	clean_list(msg.to.id)

	end
	
end

function extra(msg)
local uid = msg.message_.sender_user_id_ or false
local gid = tonumber(msg.message_.chat_id_) or false
local mid = msg.message_.id_ or false
if msg.message_.content_ and msg.message_.content_.text_ then
 text = msg.message_.content_.text_:lower() or false
else
 text = false
end
if text then
if text:match('extra') then
return msg
end
local hash = 'chat:'..gid..':extra'
local commands = redis:hkeys(hash)
for k ,v in pairs(commands) do
if match_pattern(v, text , true, false) then
local text = redis:hget(hash, v)
send_warn(gid,text)
return msg
end
end
end
return msg
end

 return {
    description = 'set extra commands',
    usage = {
      '`extra list`',
      'Show list of extra commands.',
      '',
      '`extra ([text]) ([text])`',
      'add text [1] for command and text [2] for answer.',
      '',
      '`extra - [command]`',
      'deleted command.',
      '',
      '`clean extra`',
      'deleted all extra list.'
    },
    patterns = {
	  '^extra (-) (.*)$',
	  '^(extra) (.*) (.*)$',
	  '^(extra list)$',
	  '^(clean) (extra)',
    },
    run = run,
    pre_process = extra,

  }