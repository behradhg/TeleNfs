local function doKeyboard_settings(chat_id)
    local keyboard = { {
		{text = '🛠تنظیمات گروه', callback_data = 'settings:locks:'..chat_id}
		},
		{
		{text = '⚡️انتی اسپم', callback_data = 'settings:spam:'..chat_id}
		},
		{
		{text = '🚫اخطار ها', callback_data = 'settings:warns:'..chat_id}
		},
		}
        table.insert(keyboard, line)
		local line = {{text = '🔙', callback_data = 'config:back:'..chat_id},
		}
        table.insert(keyboard, line)
        
    return keyboard
end
function menu(chat_id)
    local keyboard = {}
        local line = {
		{text = '🛠تنظیمات', callback_data = 'config:settings:'..chat_id},
		}
        table.insert(keyboard, line)
		local line = {{text = '📥قوانین', callback_data = 'config:rules:'..chat_id},
		{text = '📉درباره گروه', callback_data = 'config:about:'..chat_id},
		}
        table.insert(keyboard, line)
        local line = {{text = '📎لینک', callback_data = 'config:links:'..chat_id},
		{text = '📂لیست ها', callback_data = 'config:lists:'..chat_id},
		}
        table.insert(keyboard, line)
        
    
    return keyboard
end

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
print('2')

return true
end
	if data.owners[uid] then
	print('3')

return true
    end
	return false
end

function xline(arg, data)
td.sendInlineQueryResultMessage(msg.to.id, 0, 0, 1, data.inline_query_id_, data.results_[0].id_, cb, cmd)
end

  local function run(msg, matches)
  if not is_owner(msg , msg.to.id , msg.from.id) then
  return ':|'
  end
  if matches[1] == 'config' then 
  local res = send_inline(msg.from.id, 'گروه خود را کنترل کنید:\n\nChange the settings of your group :\n©NFS-#source', menu(msg.to.id)) 
  if res then
     reply_msg(msg.id, "_I've sent you the keyboard via private message_", ok_cb, true)
        else
   return '*please start bot* @'..config.api.username:escape()
    end
  end
  if matches[1] == 'panel' then
    td.getInlineQueryResults(config.api.id, msg.to.id, 0, 0, 'config '..msg.to.id, 0, xline, cmd)

  end
end


local function do_keyboard_spam(chat_id)
    local data = load_data('data/' .. chat_id .. '/' .. chat_id .. '.lua')
    local status = data.antispam.action
	local hash = 'settings:spam:'..chat_id..':'
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
        inline_keyboard = {
            {
                {text = 'action', callback_data = 'show:'..action},
                {text = action, callback_data = hash..'change:action'},
            },
			
			{
			{text = 'max msg', callback_data = 'show::|'}
			},
            {
                {text = '➖', callback_data = hash..':msg_down'},
                {text = tostring(num), callback_data = 'show:'..num},
                {text = '➕', callback_data = hash..':msg_up'},
            },
			{
			{text = 'max time', callback_data = 'show::|'},
			},
            {
                {text = '➖', callback_data = hash..':time_down'},
                {text = tostring(tnum), callback_data = 'show:'..tnum},
                {text = '➕', callback_data = hash..':time_up'},
            }
        }
    }
    
    --back button
    table.insert(keyboard.inline_keyboard, {{text = '🔙', callback_data = 'settings:back:'..chat_id}})
    
    return keyboard
end

local function do_keyboard_locks(chat_id)
    local data = load_data('data/' .. chat_id .. '/' .. chat_id .. '.lua')
    local keyboard = {}
     keyboard.inline_keyboard = {}
	local hash = 'settings:lock:'..chat_id..':'
          for k,v in pairs(data.lock) do
    table.insert(keyboard.inline_keyboard, {{text = k, callback_data = 'show:'..k},{text = v, callback_data = hash..k}})
	end
    table.insert(keyboard.inline_keyboard, {{text = '🔙', callback_data = 'settings:back:'..chat_id}})
    
    return keyboard
end

local function do_keyboard_rules(chat_id)
    local data = load_data('data/' .. chat_id .. '/' .. chat_id .. '.lua')
    local keyboard = {}
	if data.rules then
    table.insert(keyboard, {{text = '🗑حذف قوانین', callback_data = 'rules:delete:'..chat_id}})
    end
    table.insert(keyboard, {{text = '🔙', callback_data = 'config:back:'..chat_id}})
    return keyboard
end

local function do_keyboard_about(chat_id)
    local data = load_data('data/' .. chat_id .. '/' .. chat_id .. '.lua')
    local keyboard = {}
	if data.description then
    table.insert(keyboard, {{text = '🗑حذف توضیحات', callback_data = 'about:delete:'..chat_id}})
    end
    table.insert(keyboard, {{text = '🔙', callback_data = 'config:back:'..chat_id}})
    return keyboard
end

local function do_keyboard_lists(chat_id)
    local data = load_data('data/' .. chat_id .. '/' .. chat_id .. '.lua')
    local keyboard = {}
	if next(data.moderators) then
    table.insert(keyboard, {{text = 'مدیر ها😬', callback_data = 'list:mods:'..chat_id}})
    end
	if next(data.owners) then
    table.insert(keyboard, {{text = 'مدیر های ارشد©', callback_data = 'list:owners:'..chat_id}})
    end
	if next(data.warn_counter) then
		    table.insert(keyboard, {{text = 'افراد اخطار دیده😒', callback_data = 'list:warnuser:'..chat_id}})
end
	table.insert(keyboard, {{text = '🔙', callback_data = 'config:back:'..chat_id}})

    return keyboard
end

local function do_keyboard_mods(chat_id)
    local data = load_data('data/' .. chat_id .. '/' .. chat_id .. '.lua')
    local keyboard = {}
    table.insert(keyboard, {{text = '🔙', callback_data = 'config:lists:'..chat_id}})
    return keyboard
end

extra = {}
function behrad(msg,blocks) 
local bk = tostring(blocks[3])
if not is_moders(msg.from.id , bk) then
return print('no moderrr')
end
local key , text

if blocks[1] == 'about' then
local cmd = tostring(blocks[2])
if cmd == 'delete' then
print('tester')
local data = load_data('data/' .. bk .. '/' .. bk .. '.lua')
data.description = nil
save_data(data, 'data/' .. bk .. '/' .. bk .. '.lua')
key,text = do_keyboard_rules(bk),'توضیحات شما با موفقیت پاک شدند'
end
end

if blocks[1] == 'rules' then
local cmd = tostring(blocks[2])
if cmd == 'delete' then
print('tester')
local data = load_data('data/' .. bk .. '/' .. bk .. '.lua')
data.rules = nil
save_data(data, 'data/' .. bk .. '/' .. bk .. '.lua')
key,text = do_keyboard_rules(bk),'قوانین شما با موفقیت پاک شد'
end
end
if blocks[2] == 'settings' then
key,text = doKeyboard_settings(bk),'به تنظیمات  گروه خود خوش امدید : \n\nwelcome to inline settings :'
elseif blocks[2] == 'back' then
key,text = menu(bk),'گروه خود را کنترل کنید:\n\nChange the settings of your group :\n©NFS-#source'
elseif blocks[2] == 'rules' then
local data = load_data('data/' .. bk .. '/' .. bk .. '.lua')
if data.rules then
text = '📰قوانین گروه :\n['..data.rules..']\n©NFS-#source'
else
text = '🗞قوانینی برای گروه تایین نشده است'
end
key = do_keyboard_rules(bk)
elseif blocks[2] == 'about' then
local data = load_data('data/' .. bk .. '/' .. bk .. '.lua')
if data.description then
text = '📰درباره گروه :\n['..data.description..']\n©NFS-#source'
else
text = '🗞توضیحاتی برای گروه تایین نشده است'
end
key = do_keyboard_about(bk)
elseif blocks[2] == 'lists' then
text,key = '📊لیست مورد نظر خود را انتخاب کنید:\n\n📇*select your list :*',do_keyboard_lists(bk)
elseif blocks[1] == 'list' and blocks[2] == 'mods' then
local data = load_data('data/' .. bk .. '/' .. bk .. '.lua')
local message = "list of mod users for group :\n"
if data.moderators then
for k,v in pairs(data.moderators) do
text = message .. '- ' .. v .. ' - `' .. k .. '`\n'
end
end
key = do_keyboard_mods(bk)
elseif blocks[1] == 'list' and blocks[2] == 'owners' then
local data = load_data('data/' .. bk .. '/' .. bk .. '.lua')
local message = "list of owner users for group :\n"
if data.owners then
for k,v in pairs(data.owners) do
text = message .. '- ' .. v .. ' - `' .. k .. '`\n'
end
end
key = do_keyboard_mods(bk)
elseif blocks[1] == 'list' and blocks[2] == 'warnuser' then
local data = load_data('data/' .. bk .. '/' .. bk .. '.lua')
local message = "list of warn users of group :\n"
if data.warn_counter then
for k,v in pairs(data.warn_counter) do
text = message .. '- ' .. v .. ' - `' .. k .. '`\n'
end
end
key = do_keyboard_mods(bk)
elseif blocks[2] == 'links' then
local data = load_data('data/' .. bk .. '/' .. bk .. '.lua')
key = {}
if data.link == "" then
text = '⚓️گروه شما لینکی ندارد \n📎your group didnt have link :'
else
table.insert(key, {{text = '📎لینک گروه', url = data.link}})
text = '📎لینک گروه شما : [' .. data.link .. ']'
end
table.insert(key, {{text = '🔙', callback_data = 'config:back:'..bk}})
end
if msg.inline_message_id then
editinlineText(msg.inline_message_id,text, true, key)
else
local cid , mid  = msg.message.chat.id , msg.message.message_id
editMessageText(cid, mid, text, true, key)
end
end

local function inline(msg , matches)
local bk = matches[2]
key,text = menu(bk),'گروه خود را کنترل کنید:\n\nChange the settings of your group :\n©NFS-#source'
local response = {}
response.inline_keyboard = key
tab = {{type = "article",disable_web_page_preview = true,id = "1",
title = "پنل دکمه ای",
description = 'برای دریافت پنل مدیریتی کلیک کنید',
message_text =  url.escape(text),
reply_markup =  response},}
return send_req(send_api.."/answerInlineQuery?inline_query_id="..msg.id.."&is_personal=false&cache_time=1&results="..json.encode(tab))
end

  return {

    patterns = {
      '^(config)$',
      '^(panel)$',
    },
    run = run,
	inline_pt = {
     '(config) (.*)', 
     },
	inline = inline,
	triggers  = {
	'^(config):(settings):(.*)',
	'^(config):(rules):(.*)',
	'^(config):(lists):(.*)',
	'^(config):(back):(.*)',
	'^(config):(links):(.*)',
	'^(config):(about):(.*)',
	'^(rules):(delete):(.*)',
	'^(list):(mods):(.*)',
	'^(list):(owners):(.*)',
--	'^(list):(mutes):(.*)',
	'^(list):(warnuser):(.*)',
	'^(about):(delete):(.*)'
	},
    call = behrad,
  }
