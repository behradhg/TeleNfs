function send_cap(arg, data)
local id = data.id_
td.sendText(tonumber(msg.to.id), id, 1, 0, nil, arg, 0, 'md', ok_cb, cmd)
end
function sphoto(arg ,msgr)
local count = msgr.total_count_
if count < 1 then
return td.sendText(tonumber(msg.to.id), 0, 1, 0, nil, arg:=gsub('_', '\\%0'), 0, 'md', ok_cb, cmd)
end
local min = msgr.photos_
local random_table = min[(math.random(count) - 1)]
local pic_id = random_table.sizes_[0].photo_.persistent_id_
td.sendPhoto(tonumber(msg.to.id), 0, 1, 1, nil, pic_id, arg:gsub('`', ''):gsub('%*', ''):gsub('\\' , ''), dl_cb, arg)

end
function set_rank(uid,gid,rank)
local data = load_data(_config.chats.managed[msg.to.peer_id])
while not data.rank do
data.rank = {}
end
data.rank[uid] = rank
save_data(data, 'data/' .. gid .. '/' .. gid .. '.lua')
td.sendText(tonumber(msg.to.id), 0, 1, 0, nil, _('done\nuser *%s* rank has been set to *%s*'):format(get_uname(uid),rank), 0, 'md', ok_cb, cmd)
end

function all_by_reply(extra, success, result)
local arg = extra.cmd
local gid = tonumber(extra.to.peer_id)
local uid = tonumber(result.from.peer_id)
if arg == 'id' then
username = get_uname(uid) or false
local hash = 'msgs:'..uid..':'..gid
msgs = tonumber(redis:get(hash)) or 0
groupmsg = tonumber(redis:get('spgs:'..gid)) or 0
local msger = tonumber(((msgs / groupmsg) * 100))
local msger = math.ceil(msger)
local rank = function();local data = load_data(_config.chats.managed[msg.to.peer_id]);
if data.rank[uid] then return '\n*rank :* `'..data.rank[uid]..'`' else return '' end end
local text = _('user info : \n*user :* `%s`\n*your msgs in group :* `[%s%] %s\\`\n*All group msgs :* `%s`'):format(username,math.ceil(msgs),msger,groupmsg)..rank()
return get_pics(uid,sphoto,text)
end

if arg == 'setrank' then 
local rank = extra.rank
set_rank(uid,gid,rank)
end

end

local function cmd_by_username(extra, success, result)
    local uid = result.peer_id
	if extra.cmd == 'id' then
	username = get_uname(uid) or false
local hash = 'msgs:'..uid..':'..gid
msgs = tonumber(redis:get(hash)) or 0
groupmsg = tonumber(redis:get('spgs:'..gid)) or 0
local msger = tonumber(((msgs / groupmsg) * 100))
local msger = math.ceil(msger)
local rank = function();local data = load_data(_config.chats.managed[msg.to.peer_id]);
if data.rank[uid] then return '\n*rank :* `'..data.rank[uid]..'`' else return '' end end
local text = _('user info : \n*user :* `%s`\n*your msgs in group :* `[%s%] %s`\n*All group msgs :* `%s`'):format(username,math.ceil(msgs),msger,groupmsg)..rank()
return get_pics(uid,sphoto,text)
end
end	
	
function run(msg, matches)
print(msg.to.type)

if msg.to.type == 'user'  then
return _('✔️Your id : %s \n#nfs~source'):format(msg.from.id)
end
gid = msg.to.id
if matches[1] == 'id' and matches[2] == '@' then
return resolve_username(matches[3], cmd_by_username, {cmd = 'id'})
end

  if matches[1] == 'id' and matches[2] and not matches[2]:match('@') then
  local hid = 'ID for user :\n\n'
  local xids = {}
  if next(Data.message_.content_.entities_) then
  local min = Data.message_.content_.entities_
  for i=0,#Data.message_.content_.entities_ do
  if min[i].ID:match('MessageEntityMentionName') then
  table.insert(xids , min[i].user_id_)
  elseif min[i].ID:match('MessageEntityMention') then 
    table.insert(xids , Data.message_.content_.text_:match(min[i].offset_,min[i].length_))
  end
  end
  if #xids ~= 0 then
  return hid..table.concat(xids , '\n')
  end
  return 'no id matching'
  end
  end
  
if matches[1] == 'id' and not matches[2] then
if msg.reply_id then
msg.cmd = 'id'
return get_message(msg.reply_id, all_by_reply, msg)
end
  return _('✔️Your id : %s \n©Group id : %s'):format(msg.from.id,msg.to.id)
end



 
if matches[1] == 'me' then
username = get_uname(msg.from.id) or false
local hash = 'msgs:'..msg.from.id..':'..msg.to.id
msgs = tonumber(redis:get(hash)) or 0
groupmsg = tonumber(redis:get('spgs:'..msg.to.id)) or 0
local msger = tonumber(((msgs / groupmsg) * 100))
local msger = math.ceil(msger)
local rank = function();local data = load_data(_config.chats.managed[msg.to.peer_id]);
if data.rank and data.rank[uid] then return '\n*rank :* `'..data.rank[uid]..'`' else return '' end end
local text = _('user info : \n*user :* %s\n*your msgs in group :* `[%s]%s%s`\n*All group msgs :* `%s`'):format(username,math.ceil(msgs),'%',msger,groupmsg)..rank()
return get_pics(msg.from.id,sphoto,text)
end
 
if matches[1] == 'vp' and is_sudo(msg.from.id) then
return '*'..serpent.block(Data, {comment=false})..'*'
end

if matches[1] == 'setend' and is_sudo(msg.from.id) then
redis:set('endmsg',matches[2])
return 'set to:\n\n'  
end

if matches[1] == 'rank' and is_owner(msg, gid, uid) then
local rank = matches[2]
msg.cmd = 'setrank'
msg.rank = rank
if msg.reply_id then
return get_message(msg.reply_id, all_by_reply, msg)
end
end

end

--------------------------------------------------------------------------------

  return {
    description = 'Know your id or the id of a chat members.',
    usage = {
        '`!id`',
        'Return ID of replied user if used by reply.',
        '',
        '`!me`',
        'Return your info',
        '',
        '`id @[user_name]`',
        'Return the member username ID from the current chat.',
        '',
        '`id [name]`',
        'Search for users with name on MentionName .',
        '`id`',
        'Return your ID and the chat id if you are in one.'
      
    },
    patterns = {
      '^(me)$',
      '(rank) (.*)$',
      '^(id)$',
	  '^(id) (@)(.*)$',
      '^(id) (.*)$',
      '^(vp)$',
	  '^(setend) (.*)$'

    },
    run = run
  }

