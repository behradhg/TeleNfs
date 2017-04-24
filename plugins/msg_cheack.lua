-- start plugin by behrad
--begin some function
kicktable = {}  -- do seed anti spam
exe_antispam = {}
local function kick_user(msg, chat_id, user_id)
td.changeChatMemberStatus(chat_id, user_id, 'Kicked')
end

function send_warn(gid,text)
td.sendText(gid, 0, 1, 0, nil, text, 0, 'md', ok_cb, cmd)
end

function delete_msg(gid, msg_id , uid) -- do dlt msg
td.deleteMessages(gid, {[0] = msg_id})
if uid then
td.reportChannelSpam(gid, uid, {[0] = msg_id})

else
return
end
if not exe_antispam[uid] then
exe_antispam[uid] = 0
end

exe_antispam[uid] = tonumber(exe_antispam[uid]) + 1

if exe_antispam[uid] >= 10 then
delete_all_msg(gid,uid)
end

end

function delete_all_msg(gid,uid)

td.deleteMessagesFromUser(gid, uid)
end

local function nfs(msg)
local uid = msg.message_.sender_user_id_ or false
local gid = tonumber(msg.message_.chat_id_) or false
local mid = msg.message_.id_ or false
if uid and gid and mid then -- do some fitlers
local hash = 'msgs:'..uid..':'..gid -- add msgs
redis:incr(hash)
local hash = 'spgs:'..gid -- add msgs
redis:incr(hash)
if is_sudo(uid) then -- not for sudo users
return msg
end

if is_admin(uid) then -- not for sudo users
return msg
end

if is_globally_banned(uid) then
delete_all_msg(gid,uid)
kick_user(msg, gid, uid)
send_warn(gid,'suck it')
return
end

if is_banned(gid, uid) then
delete_all_msg(gid,uid)
kick_user(msg, gid, uid)
return
end

if _config.chats.disabled[gid] == true then  -- channel off
return 
end

if not _config.chats.managed[gid] then -- load data
print('no data',gid)
return msg
end

if is_owner(msg, gid, uid) then
return msg
end

if is_mod(msg, gid, uid) then
return msg
end
if true then

local data = load_data(_config.chats.managed[gid])

if data.lock.all == 'yes' then
delete_msg(gid, mid , uid)
end

if not msg.message_ then
msg.message_ = msg
end

 if msg and msg.message_ and msg.message_.content_ and msg.message_.content_.entities_ and next(msg.message_.content_.entities_) and data.lock.links == 'ok' then
 for i=0 ,#msg.message_.content_.entities_ do
 if msg.message_.content_.entities_[i].ID == 'MessageEntityTextUrl' then
 return delete_msg(gid, mid , uid)
 end
 end
 end
 
if msg.message_.content_.photo_ then  -- find photo
local photo_hash = 'mer_photo:' .. gid
          local is_photo_offender = redis:sismember(photo_hash, uid)
          if data.lock.photo == 'warn' then
            if is_photo_offender then
              kick_user(msg, gid, uid)
			  delete_msg(gid, mid , uid)
              redis:srem(photo_hash, uid)
            end
            if not is_photo_offender then
              redis:sadd(photo_hash, uid)
			  delete_msg(gid, mid , uid)
              send_warn(gid,'Please do not post in photo.\n'
                   .. 'Obey the rules or you will be kicked.')
            end
          end
          if data.lock.photo == 'kick' then
            kick_user(msg, gid, uid)
			delete_msg(gid, mid , uid)
            send_warn(gid, 'photo is not allowed here!')
          end
		  if data.lock.photo == 'ban' then
            delete_all_msg(gid,uid)
			kick_user(msg, gid, uid)
            send_warn(gid, 'photo is not allowed here!')
          end
		  if data.lock.photo == 'report' then
            td.reportChannelSpam(msg.chat_id_, msg.sender_user_id_, {[0] = msg.id_})
		    td.deleteMessagesFromUser(msg.chat_id_, msg.sender_user_id_)
            send_warn(gid, 'photo is not allowed here!')
          end
		  if data.lock.photo == 'del' then
		  delete_msg(gid, mid , uid)
		  send_warn(gid, 'photo is not allowed here!')
		  end
        end
		
if  msg.message_.content_.sticker_ then -- find a sticker
	local sticker_hash = 'mer_sticker:' .. gid
          local is_sticker_offender = redis:sismember(sticker_hash, uid)
          if data.lock.sticker == 'warn' then
            if is_sticker_offender then
              kick_user(msg, gid, uid)
			  delete_msg(gid, mid , uid)
              redis:srem(sticker_hash, uid)
            end
            if not is_sticker_offender then
              redis:sadd(sticker_hash, uid)
			  delete_msg(gid, mid , uid)
              send_warn(gid,'Please do not post in sticker.\n'
                   .. 'Obey the rules or you will be kicked.')
            end
          end
          if data.lock.sticker == 'kick' then
            kick_user(msg, gid, uid)
			delete_msg(gid, mid , uid)
            send_warn(gid, 'sticker is not allowed here!')
          end
		  if data.lock.sticker == 'ban' then
            delete_all_msg(gid,uid)
			kick_user(msg, gid, uid)
            send_warn(gid, 'sticker is not allowed here!')
          end
		  if data.lock.sticker == 'report' then
            td.reportChannelSpam(msg.chat_id_, msg.sender_user_id_, {[0] = msg.id_})
		    td.deleteMessagesFromUser(msg.chat_id_, msg.sender_user_id_)
            send_warn(gid, 'sticker is not allowed here!')
          end
		  if data.lock.sticker == 'del' then
		  delete_msg(gid, mid , uid)
		  send_warn(gid, 'sticker is not allowed here!')
		  end
        end
		
if  msg.message_.content_.video_ then
local video_hash = 'mer_video:' .. gid
          local is_video_offender = redis:sismember(video_hash, uid)
          if data.lock.video == 'warn' then
            if is_video_offender then
              kick_user(msg, gid, uid)
			  delete_msg(gid, mid , uid)
              redis:srem(video_hash, uid)
            end
            if not is_video_offender then
              redis:sadd(video_hash, uid)
			  delete_msg(gid, mid , uid)
              send_warn(gid,'Please do not post in video.\n'
                   .. 'Obey the rules or you will be kicked.')
            end
          end
          if data.lock.video == 'kick' then
            kick_user(msg, gid, uid)
			delete_msg(gid, mid , uid)
            send_warn(gid, 'video is not allowed here!')
          end
		  if data.lock.video == 'ban' then
            delete_all_msg(gid,uid)
			kick_user(msg, gid, uid)
            send_warn(gid, 'video is not allowed here!')
          end
		  if data.lock.video == 'report' then
            td.reportChannelSpam(msg.chat_id_, msg.sender_user_id_, {[0] = msg.id_})
		    td.deleteMessagesFromUser(msg.chat_id_, msg.sender_user_id_)
            send_warn(gid, 'video is not allowed here!')
          end
		  if data.lock.video == 'del' then
		  delete_msg(gid, mid , uid)
		  send_warn(gid, 'video is not allowed here!')
		  end
        end
		
	if  type(msg.message_.forward_info_) == 'table' then
local fwd_hash = 'mer_fwd:' .. gid
          local is_fwd_offender = redis:sismember(fwd_hash, uid)
          if data.lock.fwd == 'warn' then
            if is_fwd_offender then
              kick_user(msg, gid, uid)
			  delete_msg(gid, mid , uid)
              redis:srem(fwd_hash, uid)
            end
            if not is_fwd_offender then
              redis:sadd(fwd_hash, uid)
			  delete_msg(gid, mid , uid)
              send_warn(gid,'Please do not post in fwd.\n'
                   .. 'Obey the rules or you will be kicked.')
            end
          end
          if data.lock.fwd == 'kick' then
            kick_user(msg, gid, uid)
			delete_msg(gid, mid , uid)
            send_warn(gid, 'fwd is not allowed here!')
          end
		  if data.lock.fwd == 'ban' then
            delete_all_msg(gid,uid)
			kick_user(msg, gid, uid)
            send_warn(gid, 'fwd is not allowed here!')
          end
		  if data.lock.fwd == 'report' then
            td.reportChannelSpam(msg.chat_id_, msg.sender_user_id_, {[0] = msg.id_})
		    td.deleteMessagesFromUser(msg.chat_id_, msg.sender_user_id_)
            send_warn(gid, 'fwd is not allowed here!')
          end
		  if data.lock.fwd == 'del' then
		  delete_msg(gid, mid , uid)
		  send_warn(gid, 'fwd is not allowed here!')
		  end
        end
		
	if msg.message_.content_.animation_ then
	local gif_hash = 'mer_gif:' .. gid
          local is_gif_offender = redis:sismember(gif_hash, uid)
          if data.lock.gif == 'warn' then
            if is_gif_offender then
              kick_user(msg, gid, uid)
			  delete_msg(gid, mid , uid)
              redis:srem(gif_hash, uid)
            end
            if not is_gif_offender then
              redis:sadd(gif_hash, uid)
			  delete_msg(gid, mid , uid)
              send_warn(gid,'Please do not post in gif.\n'
                   .. 'Obey the rules or you will be kicked.')
            end
          end
          if data.lock.gif == 'kick' then
            kick_user(msg, gid, uid)
			delete_msg(gid, mid , uid)
            send_warn(gid, 'gif is not allowed here!')
          end
		  if data.lock.gif == 'ban' then
            delete_all_msg(gid,uid)
			kick_user(msg, gid, uid)
            send_warn(gid, 'gif is not allowed here!')
          end
		  if data.lock.gif == 'report' then
            td.reportChannelSpam(msg.chat_id_, msg.sender_user_id_, {[0] = msg.id_})
		    td.deleteMessagesFromUser(msg.chat_id_, msg.sender_user_id_)
            send_warn(gid, 'gif is not allowed here!')
          end
		  if data.lock.gif == 'del' then
		  delete_msg(gid, mid , uid)
		  send_warn(gid, 'gif is not allowed here!')
		  end
        end
		
		

-- do anti spamer 😌
 
 if data.antispam  and not  msg.message_.content_.ID == "MessageChatAddMembers" then
 local NUM_MSG_MAX = data.antispam.NUM_MSG_MAX or 5
 local hash = 'msgs:'..uid..':'..gid
 local msgs = tonumber(redis:get(hash) or 0)
 print(msgs)
 local max_msg = NUM_MSG_MAX * 2
 local TIME_CHECK = data.antispam.TIME_CHECK or 5
if max_msg < msgs then
 local hash = 'antispam:'..uid..':'..gid
 local msgs = tonumber(redis:get(hash) or 0)
if msgs - 1 > NUM_MSG_MAX then
local gban_hash = 'tobanall:'..uid
local ban_hash = 'ban:'..uid..':'..gid
local gbans = tonumber(redis:get(gban_hash)) or 0
local bans = tonumber(redis:get(ban_hash)) or 0
if gbans > 5 then  
send_warn(gid,"User "..uid.." globally banned (spamming)")
end
redis:incr(gban_hash)
if bans > 3 then
send_warn(gid,"User "..uid.." has been banned (spamming)")
end
send_warn(gid,"spam nkon jojo")
redis:incr(ban_hash)
kick_user(msg, gid, uid)
delete_msg(gid, mid , uid)
delete_all_msg(gid, uid)
local off_antispam = 'msgs:'..uid..':'..gid
-- redis:set(off_antispam,0)
end
redis:setex(hash, TIME_CHECK, msgs+1)
end
end

if msg.message_.content_.ID == "MessageChatChangeTitle" then
if data.lock.name == 'yes' then
if data.name then
send_warn(gid,'please dont change group name')
rename_chat(gid, data.name, ok_cb, true)
end
end
end

if msg.message_.content_ and msg.message_.content_.text_ then
local text = msg.message_.content_.text_:lower() or false
else
local text = false
end

if next(data.filters) then
local var = false
for k,v in pairs(data.filters) do
if text:match(k) then
var = v
break
end
end
if var then
delete_msg(gid, mid , uid)
if var == 'ban' then
ban_user({msg=msg, usr=uid}, gid, uid)
elseif var == 'kick' then
kick_user(msg, gid, uid)
end
end
end
xid = uid
if data.lock.bot == 'yes' then
if msg.message_.content_.ID == "MessageChatAddMembers" then
local mgs = msg.message_.content_.members_
for i = 0,#msg.message_.content_.members_ do
local uid = mgs[i].id_
if mgs[i].type_.ID == "UserTypeBot" then 
kick_user(msg, gid, uid)
end
end
if i < 3 then
kick_user(msg, gid, xid)
end
end
end
if config.autoleave and msg.message_.content_.ID == "MessageChatAddMembers" then
if data.welcome.stats == 'enable' then
send_warn(gid,data.welcome.pm)
end
local mgs = msg.message_.content_.members_
for i = 0,#msg.message_.content_.members_ do
local uid = mgs[i].id_
if uid == bot.id then
td.blockUser(xid)
send_warn(gid,'ای من خار مادرتو ....')
td.changeChatMemberStatus(msg.to.id, bot.id, 'Left')
end
end
end
if data.lock.member == 'yes' then
if msg.message_.content_.ID == "MessageChatJoinByLink" then
local uid = msg.message_.sender_user_id_ 
kick_user(msg, gid, uid)
end


end

if text then

 if text:match('([\216-\219][\128-\191])') then -- do arabic
          local arabic_hash = 'mer_arabic:' .. gid
          local is_arabic_offender = redis:sismember(arabic_hash, uid)
          if data.lock.arabic == 'warn' then
            if is_arabic_offender then
              kick_user(msg, gid, uid)
			  delete_msg(gid, mid , uid)
              redis:srem(arabic_hash, uid)
            end
            if not is_arabic_offender then
              redis:sadd(arabic_hash, uid)
			  delete_msg(gid, mid , uid)
              send_warn(gid,'Please do not post in arabic.\n'
                   .. 'Obey the rules or you will be kicked.')
            end
          end
          if data.lock.arabic == 'kick' then
            kick_user(msg, gid, uid)
			delete_msg(gid, mid , uid)
            send_warn(gid, 'Arabic is not allowed here!')
          end
		  if data.lock.arabic == 'ban' then
            delete_all_msg(gid,uid)
			kick_user(msg, gid, uid)
            send_warn(gid, 'arabic is not allowed here!')
          end
		  if data.lock.arabic == 'report' then
            td.reportChannelSpam(msg.chat_id_, msg.sender_user_id_, {[0] = msg.id_})
		    td.deleteMessagesFromUser(msg.chat_id_, msg.sender_user_id_)
            send_warn(gid, 'Arabic is not allowed here!')
          end
		  if data.lock.arabic == 'del' then
		  delete_msg(gid, mid , uid)
		  send_warn(gid, 'Arabic is not allowed here!')
		  end
        end
		
				
	
 if text:match('https://telegram.me') or text:match('https://telegram.dog') or text:match('https://tlgrm.me') or text:match('https://t.me') then --cheack links 
local links_hash = 'mer_links:' .. gid
          local is_links_offender = redis:sismember(links_hash, uid)
          if data.lock.links == 'warn' then
            if is_links_offender then
              kick_user(msg, gid, uid)
			  delete_msg(gid, mid , uid)
              redis:srem(links_hash, uid)
            end
            if not is_links_offender then
              redis:sadd(links_hash, uid)
			  delete_msg(gid, mid , uid)
              send_warn(gid,'Please do not post in links.\n'
                   .. 'Obey the rules or you will be kicked.')
            end
          end
          if data.lock.links == 'kick' then
            kick_user(msg, gid, uid)
			delete_msg(gid, mid , uid)
            send_warn(gid, 'links is not allowed here!')
          end
		  if data.lock.links == 'ban' then
            delete_all_msg(gid,uid)
			kick_user(msg, gid, uid)
            send_warn(gid, 'links is not allowed here!')
          end
		  if data.lock.links == 'report' then
            td.reportChannelSpam(msg.chat_id_, msg.sender_user_id_, {[0] = msg.id_})
		    td.deleteMessagesFromUser(msg.chat_id_, msg.sender_user_id_)
            send_warn(gid, 'links is not allowed here!')
          end
		  if data.lock.links == 'del' then
		  delete_msg(gid, mid , uid)
		  send_warn(gid, 'links is not allowed here!')
		  end
        end
		
		
	end	
		
		else 

end
return msg
end
end

local function on_edit_msg(msg)
local gid = msg.chat_id_
local mid = msg.message_id_
local text = msg.new_content_.text_
-- return msg
 if text:match('https://telegram.me') or text:match('https://telegram.dog') or text:match('https://tlgrm.me') or text:match('https://t.me') then --cheack links 
delete_msg(gid, mid)
 end
return msg
end
last_exe = 0

function corn()
if last_exe + 60 < os.time() then
last_exe = os.time()
exe_antispam = {}
end
end

return {
	patterns = {},
	pre_process = nfs,
	on_edit_msg = on_edit_msg,
	corn = corn
}
