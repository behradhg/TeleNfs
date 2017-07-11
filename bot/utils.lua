URL = require "socket.url"
http = require "socket.http"
https = require "ssl.https"
ltn12 = require "ltn12"
multipart = require 'multipart-post'
serpent = (loadfile "./libs/serpent.lua")()
feedparser = (loadfile "./libs/feedparser.lua")()
json = (loadfile "./libs/JSON.lua")() 
mimetype = (loadfile "./libs/mimetype.lua")()
redis = (loadfile "./libs/redis.lua")()
JSON = (loadfile "./libs/dkjson.lua")()
td = dofile('./libs/tg.lua')
bot_conf = {}
bot_conf.data , bot_conf.version = './data/config.lua', '1'
config_file = bot_conf.data
 
function vardump(value)
  print(serpent.block(value, {comment=false}))
end

function ok_cb(extra,  result)
if result.ID == "Error" then
vardump(result)
return api.sendMessage(msg.to.id,'#bug_finder NFS\n🐞 Sorry, a bug occurred', nil, nil, nil, nil, nil)
end
end 

function user_data(msg, data)
    if data.username_ then
        msg.from.username = data.username_
    else
        msg.from.username = false
    end
    msg.from.first_name = data.first_name_
    if data.last_name_ then
        msg.from.last_name = data.last_name_
    else
        msg.from.last_name = false
    end
    if msg.action == "MessageChatJoinByLink" then
        msg.added = {}
        msg.added[1] = {}
        msg.added[1].username = msg.from.username 
        msg.added[1].first_name = msg.from.fist_name
        msg.added[1].last_name = msg.from.last_name
    end
    return msg
end
function send_document(to, file, cb, cmd)
td.sendDocument(to:gsub('user#id',''), 0, 0, 1, nil, file)
end
function create_group(msg, name, bk)
td.createNewChannelChat(name, 1, 'My Supergroup, my rules')
td.createNewGroupChat({[0] = msg.from.id}, name)
end
function is_administrate(msg, gid)
  local var = true
  if not _config.chats.managed[tonumber(gid)] then
    var = false
    send_message(msg, '<b>I do not administrate this group</b>', 'html')
  end
  return var
end
function send_message(msg, text, md)
td.sendText(tonumber(msg.to.id), 0, 1, 0, nil, text, 0, md, ok_cb, cmd)
end 

function reply_data(msg, data)
    if data.username_ then
        msg.replied.username = data.username_
    end
    msg.replied.first_name = data.first_name_
    if data.last_name_ then 
        msg.replied.last_name = data.last_name_
    end
    return msg
end
function load_data(filename)
  if not filename then
    _data = {}
  else
    _data = loadfile(filename)() or {}
  end
  return _data
end
function return_media(msg)
    if msg.photo then
        return "MessagePhoto"
    elseif msg.sticker then
        return "MessageSticker"
    elseif msg.audio then
        return "MessageAudio"
    elseif msg.voice then
        return "MessageVoice"
    elseif msg.gif then
        return "MessageAnimation"
    elseif msg.text then
        return "MessageText"
    elseif msg.service then
        return "MessageService"
    elseif msg.video then
        return "MessageVideo"
    elseif msg.document then
        return "MessageDocument"
    elseif msg.game then
        return "MessageGame"
    end
end

function serialize_to_file(data, file, uglify)
    file = io.open(file, 'w+')
    local serialized
    if not uglify then
        serialized = serpent.block(data, {
            comment = false,
            name = '_'
        })
    else
        serialized = serpent.dump(data)
    end 
	
    file:write(serialized)
	file:flush()
    file:close()
end

-- Returns a table with matches or nil
function match_pattern(pattern, text, lower_case ,cmd)
    if text then
	if cmd then
	text = text:gsub(config.cmd,'')
	-- pattern = pattern:gsub(config.cmd,'')
	end
        local matches = {}
        if lower_case then
            matches = { string.match(text:lower(), pattern) }
        else
            matches = { string.match(text, pattern) }
        end
        if next(matches) then
            return matches
        end
    end
    -- nil
end

function get_receiver(msg)
    return msg.to.id

end

function getChatId(chat_id)
    local chat = {}
    local chat_id = tostring(chat_id)

    if chat_id:match('^-100') then
        local channel_id = chat_id:gsub('-100', '')
        chat = {ID = channel_id, type = 'channel'}
    else
        local group_id = chat_id:gsub('-', '')
        chat = {ID = group_id, type = 'group'}
    end

    return chat
end




function new_is_sudo(user_id)
    local var = false
    -- Check users id in config
    for v,user in pairs(_config.sudo_users) do
        if user == user_id then
            var = true
        end
    end
    return var
end

function lang_text(chat_id, keyword)
    local hash = 'langset:'..chat_id
    local lang = redis:get(hash)
    if not lang then
        redis:set(hash,'en')
        lang = redis:get(hash)
    end
    local hashtext = 'lang:'..lang..':'..keyword
    if redis:get(hashtext) then
        return redis:get(hashtext)
    else
        return 'Please, install your selected "'..lang..'" language by #install [`archive_name(english_lang, spanish_lang...)`]. First, active your language package like a normal plugin by it\'s name. For example, #plugins enable `english_lang`. Or set another one by typing #lang [language(en, es...)].'
    end

end

function is_number(name_id)
    if tonumber(name_id) then
        return true
    else
        return false
    end
end
function string:escape(only_markup)
	if not only_markup then
		-- insert word joiner
		self = self:gsub('([@#/.])(%w)', '%1\xE2\x81\xA0%2')
	end
	return self:gsub('[*_`]', '\\%0')
end

function string:escape_html()
	self = self:gsub('&', '&amp;')
	self = self:gsub('"', '&quot;')
	self = self:gsub('<', '&lt;'):gsub('>', '&gt;')
	return self
end

-- Remove specified formating or all markdown. This function useful for put
-- names into message. It seems not possible send arbitrary text via markdown.
function string:escape_hard(ft)
	if ft == 'bold' then
		return self:gsub('%*', '')
	elseif ft == 'italic' then
		return self:gsub('_', '\\_')
	elseif ft == 'fixed' then
		return self:gsub('`', '')
	elseif ft == 'link' then
		return self:gsub(']', '')
	else
		return self:gsub('[*_`[%]]', '')
	end
end
function string:trim() -- Trims whitespace from a string.
	local s = self:gsub('^%s*(.-)%s*$', '%1')
	return s
end

function dump(...)
	for _, value in pairs{...} do
		print(serpent.block(value, {comment=false}))
	end
end

function vtext(...)
	local lines = {}
	for _, value in pairs{...} do
		table.insert(lines, serpent.block(value, {comment=false}))
	end
	return table.concat(lines, '\n')
end

function string:vtext()
	local lines = {}
	for _, value in pairs{self} do
		table.insert(lines, serpent.block(value, {comment=false}))
	end
	return table.concat(lines, '\n')
end

function no_markdown(text, replace)
    if text then
        text = tostring(text)
        if replace then
            text = text:gsub("`", replace)
            text = text:gsub("*", replace)
            text = text:gsub("_", replace)
            return text
        end
        text = text:gsub("`", "")
        text = text:gsub("*", "")
        text = text:gsub("_", "")
        return text
    end
    return false
end

function is_admin(user_id)
  local var = false
  if _config.administrators[user_id] then
    var = true
  end
  if _config.sudo_users[user_id] then
    var = true
  end
  return var
end
function get_receiver_api(msg)
  if msg.to.peer_type == 'user' or msg.to.peer_type == 'private'  then
    return msg.from.peer_id
  end
  if msg.to.peer_type == 'chat' or msg.to.peer_type == 'group' then
    if not msg.from.api then
      return '-' .. msg.to.peer_id
    else
      return msg.to.peer_id
    end
  end
--TODO testing needed
-- if msg.to.peer_type == 'encr_chat' then
--   return msg.to.print_name
-- end
  if msg.to.peer_type == 'channel' or msg.to.peer_type == 'supergroup' then
    if not msg.from.api then
      return '-100' .. msg.to.peer_id
    else
      return msg.to.peer_id
    end
  end
end

-- User is a group owner
function is_leader(msg, chat_id, user_id)
  local var = false
  local data = load_data(_config.chats.managed[chat_id])
    if data.leader == nil then
    var = false
  elseif data.leader == user_id then
    var = true
  end
  if _config.administrators[user_id] then
    var = true
  end
  if _config.sudo_users[user_id] then
    var = true
  end 
  return var
end


-- User is a group owner
function is_owner(msg, chat_id, user_id)
  local var = false
  local data = load_data(_config.chats.managed[chat_id])
  if data.owners == nil then
    var = false
  elseif data.owners[user_id] then
    var = true
  end
  if data.leader == nil then
    var = false
  elseif data.leader == user_id then
    var = true
  end
  if _config.administrators[user_id] then
    var = true
  end
  if _config.sudo_users[user_id] then
    var = true
  end
  return var
end

-- User is a group moderator
function is_mod(msg, chat_id, user_id)
  local var = false
  local data = load_data(_config.chats.managed[chat_id])
  if data.moderators == nil then
    var = false
  elseif data.moderators[user_id] then
    var = true
  end
  if data.owners == nil then
    var = false
  elseif data.owners[user_id] then
    var = true
  end
    if data.leader == nil then
    var = false
  elseif data.leader == user_id then
    var = true
  end
  if _config.administrators[user_id] then
    var = true
  end
  if _config.sudo_users[user_id] then
    var = true
  end
  return var
end 

function user_allowed(plugin, msg)
  if plugin.moderated and not is_mod(msg, msg.to.peer_id, msg.from.peer_id) then
    if plugin.moderated and not is_owner(msg, msg.to.peer_id, msg.from.peer_id) then
	if plugin.moderated and not is_leader(msg, msg.to.peer_id, msg.from.peer_id) then
      if plugin.moderated and not is_admin(msg.from.peer_id) then
        if plugin.moderated and not is_sudo(msg.from.peer_id) then
          return false
        end
      end
    end
  end
  end
  -- If plugins privileged = true
  if plugin.privileged and not is_sudo(msg.from.peer_id) then
    return false
  end
  return true
end

function send_large_msg(destination, text)
 
td.sendText(destination, 0, 1, 0, nil, text, 0, 'md', ok_cb, cmd)

   end
   function is_sudo(user_id)
  local var = false
  if _config.sudo_users[user_id] then
    var = true
  end
  return var
end

function send_msg(receiver, text, cb_function, cb_extra) 
send_large_msg(receiver, text)
end
   function savelog(group, logtxt)
print('do log') 
-- local text = (os.date("[ %c ]=>  "..logtxt.."\n \n"))
-- local file = io.open("./groups/logs/"..group.."log.txt", "a")

-- file:write(text)

-- file:close()

end
function is_chat_msg(msg)
  if msg.to.peer_type == 'private' or msg.to.peer_type == 'user' then
    return false
  else
    return true
  end
end
function group_type(msg)
  local var = false
  if tostring(msg.to.id):match('-') then
  if tostring(msg.to.id):match('$-100') then
  var = 'cahnnel'
  elseif tostring(msg.to.id):match('$-10') then
  var = 'chat'
  end
  elseif tonumber(msg.to.id) then
  var = 'user'
  end  
  return var
  end
 function export_chat_link(chat_id,cb,cmd)

  td.exportChatInviteLink(tonumber(chat_id), cb, cmd)
  end
  function export_channel_link(chat_id,cb,cmd)

  td.exportChatInviteLink(tonumber(chat_id), cb, cmd)
  end
  function pairsByKeys(t, f)
  local a = {}
  for n in pairs(t) do
    a[#a+1] = n
  end
  table.sort(a, f)
  local i = 0      -- iterator variable
  local iter = function ()   -- iterator function
    i = i + 1
    if a[i] == nil then
      return nil
    else
      return a[i], t[a[i]]
    end
  end
  return iter
end

-- Gets coordinates for a location. 
function get_coords(msg, input)
  local url = 'https://maps.googleapis.com/maps/api/geocode/json?address=' .. URL.escape(input)

  local jstr, res = http.request(url)
  if res ~= 200 then
    reply_msg(msg.id, 'Connection error.', ok_cb, true)
    return
  end

  local jdat = json:decode(jstr)
  if jdat.status == 'ZERO_RESULTS' then
    reply_msg(msg.id, 'ZERO_RESULTS', ok_cb, true)
    return 
  end

  return {
    lat = jdat.results[1].geometry.location.lat,
    lon = jdat.results[1].geometry.location.lng,
    formatted_address = jdat.results[1].formatted_address
  }
end

function edit_tg(x)
 local msg = {}
    msg.to = {}
    msg.from = {}
    msg.replied = {}
    msg.to.id = tonumber(x.chat_id_)
    msg.from.id = tonumber(x.sender_user_id_)
	msg.from.peer_id = tonumber(msg.from.id)
	msg.to.peer_id = tonumber(msg.to.id)
	if x.content_ then
if x.content_.ID == "MessageText" then
        msg.text = x.content_.text_
    end
	else
	return nil
end
	if group_type(msg)  then
	msg.to.peer_type = group_type(msg) 
	msg.to.type = group_type(msg) 
	end
    if x.content_.caption_ then
        msg.text = x.content_.caption_
    end
    msg.date = x.date_
    msg.id = x.id_
    msg.unread = false
	    if x.reply_to_message_id_ == 0 then
        msg.reply_id = false
    else
        msg.reply_id = x.reply_to_message_id_
    end
    if x.content_.ID == "MessagePhoto" then
        msg.photo = true
    else
        msg.photo = false
    end
    if x.content_.ID == "MessageSticker" then
        msg.sticker = true
    else
        msg.sticker = false
    end
    if x.content_.ID == "MessageAudio" then
        msg.audio = true
    else
        msg.audio = false
    end
    if x.content_.ID == "MessageVoice" then
        msg.voice = true
    else
        msg.voice = false
    end
    if x.content_.ID == "MessageAnimation" then
        msg.gif = true
    else
        msg.gif = false
    end
    if x.content_.ID == "MessageVideo" then
        msg.video = true
    else
        msg.video = false
    end
    if x.content_.ID == "MessageDocument" then
        msg.document = true
    else
        msg.document = false
    end
    if x.content_.ID == "MessageGame" then
        msg.game = true
    else
        msg.game = false
    end
	
	if x.forward_info_ then
		msg.fwd = true
		msg.forward = {}
		msg.forward.from_id = x.forward_info_.sender_user_id_
		msg.forward.msg_id = x.forward_info_.data_
	else
		msg.forward = false
	end
	return msg
end

function oldtg(data)
    local msg = {}
    msg.to = {}
    msg.from = {}
    msg.replied = {}
    msg.to.id = tonumber(data.message_.chat_id_)
    msg.from.id = tonumber(data.message_.sender_user_id_)
	msg.from.peer_id = tonumber(msg.from.id)
	msg.to.peer_id = tonumber(data.message_.chat_id_)
    if data.message_.content_.ID == "MessageText" then
        msg.text = data.message_.content_.text_
    end
	if group_type(msg)  then
	msg.to.peer_type = group_type(msg) 
	msg.to.type = group_type(msg) 
	end
    if data.message_.content_.caption_ then
        msg.text = data.message_.content_.caption_
    end
    msg.date = data.message_.date_
    msg.id = data.message_.id_
    msg.unread = false
    if data.message_.reply_to_message_id_ == 0 then
        msg.reply_id = false
    else
        msg.reply_id = data.message_.reply_to_message_id_
    end
	
    if data.message_.content_.ID == "MessagePhoto" then
        msg.photo = true
    else
        msg.photo = false
    end
    if data.message_.content_.ID == "MessageSticker" then
        msg.sticker = true
    else
        msg.sticker = false
    end
    if data.message_.content_.ID == "MessageAudio" then
        msg.audio = true
    else
        msg.audio = false
    end
    if data.message_.content_.ID == "MessageVoice" then
        msg.voice = true
    else
        msg.voice = false
    end
    if data.message_.content_.ID == "MessageAnimation" then
        msg.gif = true
    else
        msg.gif = false
    end
    if data.message_.content_.ID == "MessageVideo" then
        msg.video = true
    else
        msg.video = false
    end
    if data.message_.content_.ID == "MessageDocument" then
        msg.document = true
    else
        msg.document = false
    end
    if data.message_.content_.ID == "MessageGame" then
        msg.game = true
    else
        msg.game = false
    end
	
	if data.message_.forward_info_ then
		msg.forward = true
		msg.forward = {}
		msg.forward.from_id = data.message_.forward_info_.sender_user_id_
		msg.forward.msg_id = data.message_.forward_info_.data_
	else
		msg.forward = false
	end
    if data.message_.content_.ID then
        msg.action = data.message_.content_.ID
    end
	if data.message_.content_.ID == "MessageChatAddMembers" or data.message_.content_.ID == "MessageChatDeleteMember" or
        data.message_.content_.ID == "MessageChatChangeTitle" or data.message_.content_.ID == "MessageChatChangePhoto" or
        data.message_.content_.ID == "MessageChatJoinByLink" or data.message_.content_.ID == "MessageGameScore" then
        msg.service = true
    else
        msg.service = false
    end
    local new_members = data.message_.content_.members_
    if new_members then
        msg.added = {}
        for i = 0, #new_members, 1 do
            k = i+1
            msg.added[k] = {}
            if new_members[i].username_ then
                msg.added[k].username = new_members[i].username_
            else
                msg.added[k].username = false
            end
            msg.added[k].first_name = new_members[i].first_name_
            if new_members[i].last_name_ then
                msg.added[k].last_name = new_members[i].last_name_
            else
                msg.added[k].last_name = false
            end
        end
    end
    return msg
end


 function user_print_name(user)
   -- if user.print_name then
      -- return user.print_name
   -- end
   -- local text = ''
   -- if user.first_name then
      -- text = user.last_name..' '
   -- end
   -- if user.lastname then
      -- text = text..user.last_name 
   -- end
   return 'text'
end
function prterr(text)  -- write anythins by  color

    print('\27[33m' .. text .. '\27[39m')

	end

function file_exists(name)
  local f = io.open(name,'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end
function resolve_username(username,cb,cmd)
td.searchPublicChat(username,do_username,{cb=cb,cmd=cmd})
end
function old_reply(bk,result)
  local msg = {}
local uid = result.sender_user_id_
msg.from = {}
msg.from.peer_id = uid
bk.cb(bk.cmd,1,msg)
  end
  
 function get_message(id, cb, cmd)

 td.getMessage(msg.to.id, id, old_reply,{cb=cb,cmd=cmd})
 end
 
function do_username(bk,result)

local msg = {}
local uid = result.type_.user_.id_
local un = result.type_.user_.username_
msg.peer_id = uid
msg.username = un or uid
bk.cb(bk.cmd,1,msg)
end

function rename_channel(ch_id,name,cb,cmd)
td.changeChatTitle(ch_id, name,cb,cmd)
end
function rename_chat(ch_id,name,cb,cmd)
td.changeChatTitle(ch_id, name,cb,cmd)
end

function sendText(chat_id, reply_to_message_id, text, disable_web_page_preview, parse_mode, cb, cmd)
  local parse_mode = parse_mode or 'HTML'
  local disable_web_page_preview = disable_web_page_preview or 1
  local message = {}
  local n = 1
  -- If text is longer than 4096 chars, send multiple messages.
  -- https://core.telegram.org/method/messages.sendMessage
  while #text > 4096 do
    message[n] = text:sub(1, 4096)
    text = text:sub(4096, #text)
    parse_mode = nil
    n = n + 1
  end
  message[n] = text

  for i = 1, #message do
    local reply = i > 1 and 0 or reply_to_message_id
    td.sendText(chat_id, reply, 0, 1, nil, message[i], disable_web_page_preview, parse_mode, cb, cmd)
  end
end

function reply_msg(id, text, ok_cb, bk)
td.sendText(msg.to.id, id, 1, 0, nil, text, 0, 'md', ok_cb, bk)
return
end 
function channel_set_admin(ch_id, u_id, ok_cb, bk)
td.changeChatMemberStatus(ch_id:gsub('channel#id',''), u_id:gsub('user#id',''), 'Editor')
end
function channel_del_admin(ch_id, u_id, ok_cb, bk)
td.changeChatMemberStatus(ch_id:gsub('channel#id',''), u_id:gsub('user#id',''), 'Member')
end
function get_receiver(msg)
--  old tg function s (BK)
return msg.to.id
end
function is_plugin_disabled_on_chat(plugin_name, receiver)
  
  local disabled_chats = _config.enabled_plugins.disabled_on_chat
  -- Table exists and chat has disabled plugins (BK)
  
  if disabled_chats and disabled_chats[receiver] then
    -- Checks if plugin is disabled on this chat
    
	for disabled_plugin,disabled in pairs(disabled_chats[receiver]) do
      if disabled_plugin == plugin_name and disabled then
      
	  return true
      end
    end
  end 
  return false
end
function string.random(length)
   local str = "";
   for i = 1, length do
      math.random(97, 122)
      str = str..string.char(math.random(97, 122));
   end
   return str;
end

function get_pics(uid,cb,cmd)
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = uid,offset_ = 0,limit_ = 100}, cb or dl_cb, cmd)
end
function string.random(length)
   local str = "";
   for i = 1, length do
      math.random(97, 122)
      str = str..string.char(math.random(97, 122));
   end
   return str;
end

function string:split(sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

-- DEPRECATED
function string.trim(s)
  print("string.trim(s) is DEPRECATED use string:trim() instead")
  return s:gsub("^%s*(.-)%s*$", "%1")
end

-- Removes spaces
function string:trim()
  return self:gsub("^%s*(.-)%s*$", "%1")
end
function get_http_file_name(url, headers)
  -- Eg: foo.var
  local file_name = url:match("[^%w]+([%.%w]+)$")
  -- Any delimited alphanumeric on the url
  file_name = file_name or url:match("[^%w]+(%w+)[^%w]+$")
  -- Random name, hope content-type works
  file_name = file_name or str:random(5)

  local content_type = headers["content-type"]

  local extension = nil
  if content_type then
    extension = mimetype.get_mime_extension(content_type)
  end
  if extension then
    file_name = file_name.."."..extension
  end

  local disposition = headers["content-disposition"]
  if disposition then
    -- attachment; filename=CodeCogsEqn.png
    file_name = disposition:match('filename=([^;]+)') or file_name
  end

  return file_name
end

--  Saves file to /tmp/. If file_name isn't provided,
-- will get the text after the last "/" for filename
-- and content-type for extension
function download_to_file(url, file_name)
  print("url to download: "..url)

  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }

  -- nil, code, headers, status
  local response = nil

  if url:starts('https') then
    options.redirect = false
    response = {https.request(options)}
  else
    response = {http.request(options)}
  end

  local code = response[2]
  local headers = response[3]
  local status = response[4]

  if code ~= 200 then return nil end

  file_name = file_name or get_http_file_name(url, headers)

  local file_path = "data/tmp/"..file_name
  print("Saved to: "..file_path)

  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()

  return file_path
end

function vardump(value)
  print(serpent.block(value, {comment=false}))
end

function vp(value)
  print(serpent.block(value, {comment=false}))
end

-- taken from http://stackoverflow.com/a/11130774/3163199
function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  for filename in popen('ls -a "'..directory..'"'):lines() do
    i = i + 1
    t[i] = filename
  end
  return t
end

-- http://www.lua.org/manual/5.2/manual.html#pdf-io.popen
function run_command(str)
  local cmd = io.popen(str)
  local result = cmd:read('*all')
  cmd:close()
  return result
end
function plugins_names( )
  local files = {}
  for k, v in pairs(scandir("plugins")) do
    -- Ends with .lua
    if (v:match(".lua$")) then
      table.insert(files, v)
    end
  end
  return files
end



-- Save into file the data serialized for lua.
-- Set uglify true to minify the file.
function serialize_to_file(data, file, uglify)
  file = io.open(file, 'w+')
  local serialized
  if not uglify then
    serialized = serpent.block(data, {
        comment = false,
        name = '_'
      })
  else
    serialized = serpent.dump(data)
  end
  file:write(serialized)
  file:close()
end


function save_data(data, file, uglify)
  file = io.open(file, 'w+')
  local serialized
  if not uglify then
    serialized = serpent.block(data, {
      comment = false,
      name = '_'
    })
  else
    serialized = serpent.dump(data)
  end
  file:write(serialized)
  file:close()
end
function string:isempty()
  return self == nil or self == ''
end

-- Returns true if the string is blank
function string:isblank()
  self = self:trim()
  return self:isempty()
end

-- DEPRECATED!!!!!
function string.starts(String, Start)
  print("string.starts(String, Start) is DEPRECATED use string:starts(text) instead")
  return Start == string.sub(String,1,string.len(Start))
end

-- Returns true if String starts with Start
function string:starts(text)
  return text == string.sub(self,1,string.len(text))
end

-- Send image to user and delete it when finished.
-- cb_function and cb_extra are optionals callback
function _send_photo(receiver, file_path, cb_function, cb_extra)
 td.sendPhoto(receiver, 0, 1, 1, nil, file_path, '@MaxTeamCh',cb_function,cb_extra)

end

-- Download the image and send to receiver, it will be deleted.
-- cb_function and cb_extra are optionals callback
function send_photo_from_url(receiver, url, cb_function, cb_extra)
  -- If callback not provided
  cb_function = cb_function or ok_cb
  cb_extra = cb_extra or false

  local file_path = download_to_file(url, false)
  if not file_path then -- Error
    local text = 'Error downloading the image'
    send_msg(receiver, text, cb_function, cb_extra)
  else
    print("File path: "..file_path)
    _send_photo(receiver, file_path, cb_function, cb_extra)
  end
end

-- Same as send_photo_from_url but as callback function
function send_photo_from_url_callback(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local url = cb_extra.url

  local file_path = download_to_file(url, false)
  if not file_path then -- Error
    local text = 'Error downloading the image'
    send_msg(receiver, text, ok_cb, false)
  else
    print("File path: "..file_path)
    _send_photo(receiver, file_path, ok_cb, false)
  end
end
