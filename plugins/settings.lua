function is_moders(uid , gid)
local test = mem_info(gid, uid)
if test then
local stats = test.result.status
print(stats)
if stats == ("creator" or "administrator") then
print('1')
return true

end
end
local data = load_data('data/' .. gid .. '/' .. gid .. '.lua')
if data.moderators[uid] then
return true
end

if data.leader == uid then
return true
end
 
	if data.owners[uid] then
return true
    end
	
	
	return false
end

local function do_keyboard_spam(chat_id)
    local data = load_data('data/' .. chat_id .. '/' .. chat_id .. '.lua')
    local status = data.antispam.action
	local hash = 'settingspam:%s:'..chat_id
    if status == 'kick' then
        action = "👞️ kick"
    elseif status == 'ban' then
        action = "🔨 ️ban"
	else
        action = "🔴 none"
    end
    local num = data.antispam.NUM_MSG_MAX
	local tnum = data.antispam.TIME_CHECK
    local keyboard = {
            {
                {text = 'Action', callback_data = 'show:'..action},
                {text = action, callback_data = hash:format('action')},
            },
			
			{
			{text = 'max msg', callback_data = 'show::|'}
			},
            {
                {text = '➖', callback_data = hash:format('msg_down')},
                {text = tostring(num), callback_data = 'show:'..num},
                {text = '➕', callback_data = hash:format('msg_up')},
            },
			{
			{text = 'max time', callback_data = 'show::|'},
			},
            {
                {text = '➖', callback_data = hash:format('time_down')},
                {text = tostring(tnum), callback_data = 'show:'..tnum},
                {text = '➕', callback_data = hash:format('time_up')},
            }
    }
        table.insert(keyboard, {{text = '🔙', callback_data = 'config:settings:'..chat_id}})
    
    return keyboard
end

function do_keyboard_warn(chat_id)
    local data = load_data('data/' .. chat_id .. '/' .. chat_id .. '.lua')
    local status = data.warn_settings.action
	local hash = 'settingwarn:%s:'..chat_id
    if status == 'kick' then
        action = "👞️ kick"
    elseif status == 'ban' then
        action = "🔨 ️ban"
	else
        action = "🔴 none"
    end
    local num = data.warn_settings.max or 5
    local keyboard = {
            {
                {text = 'action', callback_data = 'show:'..action},
                {text = action, callback_data = hash:format('action')},
            },
			
			{
			{text = 'max warning', callback_data = 'show::|'}
			},
            {
                {text = '➖', callback_data = hash:format('dwon')},
                {text = tostring(num), callback_data = 'show:'..num},
                {text = '➕', callback_data = hash:format('up')},
            },
    }
        table.insert(keyboard, {{text = '🔙', callback_data = 'config:settings:'..chat_id}})
    
    return keyboard
end


local function do_keyboard_locks(chat_id)
    local data = load_data('data/' .. chat_id .. '/' .. chat_id .. '.lua')
    local keyboard = {}
	local hash = 'setting:%s:'..chat_id
     for k,v in pairs(data.lock) do
	 if k == ('name' or 'all' or 'bot' or 'member') then
	 else
	 if v == 'kick' then
        action = "👞️ kick"
    elseif v == 'ban' then
        action = "🔨 ️ban"
	 elseif v == 'del' then
        action = "🚫 del"	
	elseif v == 'report' then
        action = "📝 report"
	elseif v == 'warn' then
	action = '🚷 warn'
	else
        action = "🔴 ok"
    end
    table.insert(keyboard, {{text = k, callback_data = 'show:'..k},{text = action, callback_data = hash:format(k)}})
	end
	end
    table.insert(keyboard, {{text = '🔙', callback_data = 'config:settings:'..chat_id}})
    return keyboard
end

function math:lock_match(main)
local v = 'ok'
if main == 'ok' then
v = 'kick'
elseif main == 'kick' then
v = 'ban'
elseif main == 'ban' then
v = 'del'
elseif main == 'del' then
v = 'report'
elseif main == 'report' then
v = 'warn'
elseif main == 'warn' then
v = 'ok'
end
return v
end
function plug(msg,blocks) 
local bk = tostring(blocks[3])
local key , text
if not is_moders(msg.from.id , bk) then
return print('no moderrr')
end
if blocks[1] == 'settingspam' then
local cmd = tostring(blocks[2])
local data = load_data('data/' .. bk .. '/' .. bk .. '.lua')
local max_m = tonumber(data.antispam.NUM_MSG_MAX)
if cmd == 'msg_up' then
data.antispam.NUM_MSG_MAX = max_m + 1
elseif cmd == 'msg_down'  then
data.antispam.NUM_MSG_MAX = max_m - 1
end
local max_t = tonumber(data.antispam.TIME_CHECK)
if cmd == 'time_up' then
data.antispam.TIME_CHECK = max_t + 1
elseif cmd == 'time_down'  then
data.antispam.TIME_CHECK = max_t - 1
end

if cmd == 'action' then
local main = data.antispam.action
local v = 'ok'
if main == 'ok' then
v = 'kick'
elseif main == 'kick' then
v = 'ban'
elseif main == 'ban' then
v = 'ok'
end
data.antispam.action = v
end
save_data(data, 'data/' .. bk .. '/' .. bk .. '.lua')
key,text = do_keyboard_spam(bk),'🖱تنظیمات شم با موفقیت تغیرر کرد :\n'
end

if blocks[1] == 'settingwarn' then
local cmd = tostring(blocks[2])
local data = load_data('data/' .. bk .. '/' .. bk .. '.lua')
local t_num = data.warn_settings.max or 5
if cmd == 'up' then
data.warn_settings.max = t_num + 1
elseif cmd == 'down' then
data.warn_settings.max = t_num - 1

elseif cmd == 'action' then
local main = data.warn_settings.action
if main == 'kick' then
v = 'ban'
else
v = 'kick'
end
data.warn_settings.action = v
end
key,text = do_keyboard_warn(bk),'تغیرات اخطار ها :\n'
save_data(data, 'data/' .. bk .. '/' .. bk .. '.lua')
end

if blocks[1] == 'setting' then
local mod_lock = tostring(blocks[2])
local data = load_data('data/' .. bk .. '/' .. bk .. '.lua')
local lock_type = data.lock[mod_lock]
local to_lock = math:lock_match(lock_type)
data.lock[mod_lock] = to_lock
save_data(data, 'data/' .. bk .. '/' .. bk .. '.lua')
key,text = do_keyboard_locks(bk),'با موفقیت  انجام شد دستور بعدی شما:'
end

if blocks[2] == 'locks' then
key,text = do_keyboard_locks(bk),'😕به تنظیمات قفل های ربات خوش امدید :'
elseif blocks[2] == 'spam' then
key,text = do_keyboard_spam(bk),'🖱شما وارد تنظیمات انتی اسپمگروه خود شدید :\n'
elseif blocks[2] == 'warns' then
key,text = do_keyboard_warn(bk),'تنظیمات اخطار ها برای گروه شما :\n'
end
if msg.inline_message_id then
editinlineText(msg.inline_message_id,text, true, key)
else
local cid , mid  = msg.message.chat.id , msg.message.message_id
editMessageText(cid, mid, text, true, key)
end
end


  return {
	triggers  = {
	'^(settings):(locks):(.*)',
	'^(settings):(spam):(.*)',
	'^(settings):(warns):(.*)',
	'^(setting):(.*):(.*)$',
	'^(settingspam):(.*):(.*)$',
	'^(settingwarn):(.*):(.*)$',
	},
    call = plug,
  }
