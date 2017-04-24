expiree = {}
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



function run(msg, matches)
local gid = msg.to.peer_id
if matches[1] == 'setexpire' and is_sudo(msg.from.peer_id) then
local timer = matches[2]
if tonumber(timer) then
local now = os.date('%j')
local timer = now + tonumber(timer)
local data = load_data(_config.chats.managed[msg.to.peer_id])
data.expiretime = timer
save_data(data, 'data/' .. msg.to.peer_id .. '/' .. msg.to.peer_id .. '.lua')
return 'تنظیم شد برای '..math:source(tonumber(matches[2]))..' تنظیم شد '
end
end

if matches[1] == 'expire' then
local data = load_data(_config.chats.managed[gid])
if not data.expiretime then
return 'تاریخ انقضا تنظیم نشده است'
elseif tonumber(data.expiretime) then
local now = os.date('%j')
local time = os.difftime(tonumber(data.expiretime),now)
return 'زمان انقضای گروه شما '..math:source(time)..' دیگر می باشد'
end
end
end

function expire(msg)
local uid = msg.message_.sender_user_id_ or false
local gid = tonumber(msg.message_.chat_id_) or false
local mid = msg.message_.id_ or false
local chat_id = msg.chat_id_
if not expiree[gid] then expiree[gid] = {} end
if is_owner(msg, gid, uid) then
print('loadeddd')
local data = load_data(_config.chats.managed[gid])
if not data.expiretime then
return msg
end
local now = os.date('%j')
local time = os.difftime(tonumber(data.expiretime),now)
if time == 5 and not expiree[gid]['5'] then
expiree[gid]['5'] = true
send_warn(gid,'تاریخ انقضای گروه شما کمتر از 5 روز می باشد')
elseif time == 4 and not expiree[gid]['4'] then
expiree[gid]['4'] = true
send_warn(gid,'تاریخ انقضای گروه شما کم تر از 4 روز است')
elseif time == 3 and not expiree[gid]['4'] then
expiree[gid]['3'] = true
send_warn(gid,'تاریخ انقضای گروه شما کم تر از 3 روز است')
elseif time == 2 and not expiree[gid]['4'] then
expiree[gid]['2'] = true
send_warn(gid,'تاریخ انقضای گروه شما کم تر از 2 روز است')
elseif time == 1 and not expiree[gid]['4'] then
expiree[gid]['1'] = true
send_warn(gid,'تاریخ انقضای گروه شما کم تر از 1 روز است')
elseif time == 0 then
config.chats.managed[chat_id] = nil
save_config()
send_warn(gid,'گروه شما از لیست گروه های مدیریتی ربات حذف شد \n دیتا گروه شما تا 2 ساعت دیگر در سرور های باقی می مانند')
tdcli.changeChatMemberStatus(msg.to.id, bot.id, 'Left', dl_cb, nil)
end
end
return msg
end

  return {
  description = 'expire group os time for delet group data.',
    usage = {
        'setexpire (day)',
		'set expire time.',
		''
    },
    patterns = {
      '^(setexpire) (.*)$',
      '^(expire)$',
    },
    run = run,
	pre_process = expire,
  }

