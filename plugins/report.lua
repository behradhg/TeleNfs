do

  local function report(chat_id, msg_id, reporter, description)
    local text = _('• <b>Message reported by</b>: %s'):format(reporter)
    local link = redis:get('link' .. chat_id)
    local title = redis:get('title' .. chat_id) or 'no name'
    local logchat = redis:get('log' .. chat_id)
    if link then
      text = text .. _('\n• <b>Group</b>: %s (%s)'):format(title, link)
    else
      text = text .. _('\n• <b>Group</b>: %s'):format(title)
    end

    if #description > 1 then
      text = text .. _('\n• <b>Description</b>: <i>%s</i>'):format(description)
    end
	local x =  load_data(_config.chats.managed[msg.to.id])
	for k,v in pairs(x.owners) do
	    api.sendMessage(k, text, 'html', nil, nil, true)
    end
  end

--------------------------------------------------------------------------------

  local function run(msg, matches)
  if msg.to.type == 'user' then
  return
  end
    local chat_id, user_id  = msg.to.id,msg.from.id
    local desc = matches[2] or ''
    local text = _('Moderators has been notified!')
    if msg.reply_id then
      td.getUser(user_id, function(a, d)
        local name = d.first_name_ .. ' [<code>' .. d.id_ .. '</code>]'
        local name = d.username_ and '@' .. d.username_ .. ' ' .. name or name
        report(a.chat_id, a.msg_id, name, a.desc)
      end, {chat_id = chat_id, msg_id = msg.id, desc = desc})
    else
      text = _('Please reply the message and give a description, e.g <code>!report [description]</code>')
    end
    return text
  end

--------------------------------------------------------------------------------

  return {
    description = 'Notifies all moderators of an issue.',
    usage = {
        '<code>!report [description]</code>',
        'Report a replied message and give a description.',
        '',
    },
    patterns = {
      '^(report)$',
      '^(report) (.*)',
    },
    run = run
  }

end