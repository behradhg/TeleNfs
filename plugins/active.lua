local function checktodaygr(cb_extra, success, result)
	local hash = ''
	local thash=''
	for k,user in pairs(result.members) do
	thash = 'today:'..user.peer_id
	if redis:get(thash) then
	if redis:get(thash) < os.date("%x",os.time() + 16200) then
    hash = 'utmsgst:'..user.peer_id..':'..cb_extra
    redis:set(hash,0)
    hash = 'utmsgph:'..user.peer_id..':'..cb_extra
   redis:set(hash,0)
    hash = 'utmsgtex:'..user.peer_id..':'..cb_extra
    redis:set(hash,0)
    hash = 'utmsgoth:'..user.peer_id..':'..cb_extra
    redis:set(hash,0)
	redis:set(thash,os.date("%x",os.time() + 16200))
	end
	else
	redis:set(thash,os.date("%x",os.time() + 16200))
	end
	end
end
function checktodaych(cb_extra, success, result)
	local hash = ''
	local thash=''
	for k,user in pairs(result) do
	thash = 'today:'..user.peer_id
	if redis:get(thash) then
	if redis:get(thash) < os.date("%x",os.time() + 16200) then
    hash = 'utmsgst:'..user.peer_id..':'..cb_extra
    redis:set(hash,0)
    hash = 'utmsgph:'..user.peer_id..':'..cb_extra
   redis:set(hash,0)
    hash = 'utmsgtex:'..user.peer_id..':'..cb_extra
    redis:set(hash,0)
    hash = 'utmsgoth:'..user.peer_id..':'..cb_extra
    redis:set(hash,0)
	redis:set(thash,os.date("%x",os.time() + 16200))
	end
	else
	redis:set(thash,os.date("%x",os.time() + 16200))
	end
	end
end
local function cron()

end

local function pre_process(msg)
local uid = msg.message_.sender_user_id_ or false
local gid = tonumber(msg.message_.chat_id_) or false
local mid = msg.message_.id_ or false
if msg.message_.content_.photo_ then 
local hash = 'utmsgph:'..uid..':'..gid
    redis:incr(hash)
end
if  msg.message_.content_.sticker_ then
    local hash = 'utmsgst:'..uid..':'..gid
    redis:incr(hash)
end
if msg.message_.content_ and msg.message_.content_.text_ then
    local hash = 'utmsgtex:'..uid..':'..gid
    redis:incr(hash)
end
return msg
end
local function getactivech(cb_extra,result)
local maxst,maxph,maxtex,maxoth,maxuser,maxid,maxstat = {},{},{},{},{},{},{}
for i = 1 ,3 do
    maxstat[i] = 0
    maxuser[i] = ''
	end
	min = result.members_
	for i = 0 ,#min do
	uid = min[i].user_id_
    local shash = 'utmsgst:'..uid..':'..cb_extra
    local phash = 'utmsgph:'..uid..':'..cb_extra
    local thash = 'utmsgtex:'..uid..':'..cb_extra
    if not redis:get(shash) then
    redis:set(shash,0)
   end
       if not redis:get(phash) then
    redis:set(phash,0)
   end
       if not redis:get(thash) then
    redis:set(thash,0)
   end

   if  tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash))  > maxstat[1] then
	maxuser[3] = maxuser[2]
	maxstat[3] = maxstat[2]
	maxid[3] = maxid[2]
	maxuser[2] = maxuser[1]
	maxstat[2] = maxstat[1]
	maxid[2] = maxid[1]
	maxuser[1] = get_uname(uid)
	maxid[1] = uid
	maxstat[1] = tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) 
	elseif tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash))  > maxstat[2] then
	maxuser[3] = maxuser[2]
	maxstat[3] = maxstat[2]
	maxid[3] = maxid[2]
	maxuser[2] = get_uname(uid)
	maxid[2] = uid
	maxstat[2] = tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) 
	elseif tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash))  > maxstat[3] then
	maxuser[3] = get_uname(uid)
	maxid[3] = uid
	maxstat[3] = tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) 
	end
	end
	maxst[1] = redis:get('utmsgst:'..maxid[1]..':'..cb_extra)
	maxph[1] = redis:get('utmsgph:'..maxid[1]..':'..cb_extra)
	maxtex[1] = redis:get('utmsgtex:'..maxid[1]..':'..cb_extra)
	if maxid[2] then
	maxst[2] = redis:get('utmsgst:'..maxid[2]..':'..cb_extra)
	maxph[2] = redis:get('utmsgph:'..maxid[2]..':'..cb_extra)
	maxtex[2] = redis:get('utmsgtex:'..maxid[2]..':'..cb_extra)
	end
	if maxid[3] then
	maxst[3] = redis:get('utmsgst:'..maxid[3]..':'..cb_extra)
	maxph[3] = redis:get('utmsgph:'..maxid[3]..':'..cb_extra)
	maxtex[3] = redis:get('utmsgtex:'..maxid[3]..':'..cb_extra)
	end
	if not maxuser[1] or maxuser[1] == '' then
	maxuser[1] = 'ندارد'
	else
	maxuser[1] = maxuser[1]
	end
	if not maxuser[2] or maxuser[2] == '' then
	maxuser[2] = 'ندارد'
	else
	maxuser[2] = maxuser[2]
	end
	if not maxuser[3] or maxuser[3] == '' then
	maxuser[3] = 'ندارد'
	else
	maxuser[3] = maxuser[3]
end 
local text = _('♨️active users for today :\n1⃣ 〖%s〗\n📨Number of user msgs: %s\n👾stickers : %s\n📷Photo count: %s\n📃texts: %s'):format(maxuser[1],(maxtex[1] + maxph[1] + maxst[1]),maxst[1],maxph[1],maxtex[1])
if maxid[2] then
if not maxid[3] then  
text = text.._('\n 2⃣  〖%s〗\n📨Number of user msgs: %s\n👾sticker: %s\n📷Photo: %s\n📃texts: %s'):format(maxuser[2],maxtex[2] + maxph[2] + maxst[2],maxst[2],maxph[2],maxtex[2])
else 
text = text.._('\n 2⃣  〖%s〗\n📨 Number of user msgs: %s\n👾sticker: %s\n📷Photo: %s\n📃 texts: %s\n 3⃣  〖%s〗\n📨Number of user msgs: %s\n👾sticker: %s\n📷Photo: %s\n📃 texts: %s'):format(maxuser[2],maxtex[2] + maxph[2] + maxst[2],maxst[2],maxph[2],maxtex[2],maxuser[3],maxtex[3] + maxph[3] + maxst[3],maxst[3],maxph[3],maxtex[3])
end
end
td.sendText(tonumber(msg.to.id), 0, 1, 0, nil, text, 0, 'html', ok_cb, cmd)
end

local function clear_activech(cb_extra,result)
	min = result.members_
	for i = 0 ,#min do
	uid = min[i].user_id_
    local shash = 'utmsgst:'..uid..':'..cb_extra
    local phash = 'utmsgph:'..uid..':'..cb_extra
    local thash = 'utmsgtex:'..uid..':'..cb_extra
    redis:set(shash,0)
    redis:set(phash,0)
    redis:set(thash,0)
   end
end

local function run(msg,matches)
if matches[2] then
td.getChannelMembers(msg.to.id, 0, 'Recent', 100,clear_activech , msg.to.id)
return "*success!* active list has been cleared"
end

if msg.to.type == 'cahnnel' then 
td.getChannelMembers(msg.to.id, 0, 'Recent', 100,getactivech , msg.to.id)
end

end
return {
 description = 'show active users',
    usage = {
        '<code>active</code>',
        'Get a active users list. ',

      
    },
  patterns = {
	"^(active)$",
	"^(active) (clear)$",
  }, 
  pre_process = pre_process,
  cron = cron,
  run = run
}

-- edited by behrad
