users = {}

 function load_data(filename)
  if not filename then
    _groups_data = {}
  else
  print(filename)
    _groups_data = loadfile(filename)()
  end 
  return _groups_data
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

    local function doKeyboard_settings(data,chat_id)

        local keyboard = {}
    
    for media, default_status in pairs(data.lock) do
    	    local status = data.lock[media]
              local line = {media..' - '..status}
        table.insert(keyboard, line)
    end

	 table.insert(keyboard, {'🔙'})

	return keyboard
	end
	    local mkey = {{"ورود به پنل مدیریتی گروه","خرید سکه"},{'گروه رایگان','راهنما'},{'پشتبانی','زیر مجموعه'},{'خرید گروه'}}
	panl =  {{'تنظیمات'},{'دریافت اطلاعات','لیست مدیران'},{'بازگشت به تنظیمات اولیه'},{'افراد ساکت','افراد مسدود'},{'خاموشن کردن گروه','پاک کردن'},{'بازگشت به منوی اصلی','امتیاز دادن به ربات'}}
function run(msg)
local userid = msg.chat.id
if not db:get('point:'..msg.chat.id) then
db:set('point:'..msg.chat.id,0)
end

if not users[userid] then
users[userid] = {}
end
if not users[userid].tlist then
users[userid].tlist = {}
end

    local to = db:hget('step',msg.from.id)

if  msg.text:lower():match("^(/start)") or msg.text == 'بازگشت به منوی اصلی' then
if msg.text:match("^(/start) (.*)") then
print(msg.text)
    local id = msg.text:match("^/start (.*)")
if tonumber(id)  then 
    local ponted = db:incrby('point:'..id,9)
if ponted > 50 then
db:set('point:'..id,0)
db:hset('step',id,'get_gp')
send_key(msg.from.id, 'شما برنده روه ماشدید\nلطفا شماره خود را به اشتراک بگذارید', {{{text='شماره شما',request_contact=true}},{'بازگشت به منوی اصلی'}}, true)
end
end
end
db:hset('step',msg.from.id,'main')
return send_key(msg.from.id, 'یکی از دکمه ها را انتخاب کنید', mkey, true)
elseif msg.text:lower() == 'ورود به پنل مدیریتی گروه' and to == 'main' then
db:hset('step',msg.from.id,'active_group')
       local key = {}
for k,v in pairs (users[userid].tlist) do
table.insert(key,{k})
end
table.insert(key,{'بازگشت به منوی اصلی'})
return send_key(msg.from.id, 'لطفا توکن گروه خود را به من ارسال کنید تا به گروه شما متصل بشم\n`اگه گروه شما توکن ندارد از پشتیانی درخواست توکن کنید`', key, true)
       elseif msg.text:lower() == 'گروه رایگان' and to == 'main' then
    local link = '[https://t.me/NfsHelperBot?start='..msg.from.id..']'
return send_key(msg.from.id, [[لینک کاربری شما
برای دریافت گروه رایگان ویژه و متصل به پنل کاربری
لطفا لینک زیر را در گروه های خود پخش کنید 
زمانی که تعداد زیر مجموعه های شما به 50 برسد 
برای شما پیغامی  برای دریافت لینک ارسال می شود و بعد از دریافت لینک 
ربات عضو گروه شما می شود و توکن برای شما ارسال می شود]]..'\n '..link..'\n*Power by Nfs*' , mkey, true)
elseif msg.text:lower() == 'خرید سکه' and to == 'main' then
nerkh = {{"5000 سکه",'10000 سکه'},{'15000 سکه'},{'بازگشت به منوی اصلی'}}
local back = {{'بازگشت به منوی اصلی'}}
return send_key(msg.from.id, 'یکی از گزینه های زیر رو انتخواب کنید', nerkh, true)
elseif msg.text:lower() == '5000 سکه' and to == 'main' then
return send_key(msg.from.id, [[برای خرید 5000 سکه از لینک زیر استفاده کنید ]] , back, true)
elseif msg.text:lower() == '10000 سکه' and to == 'main' then
return send_key(msg.from.id, [[برای خرید 1000 سکه از لینک زیر استفاده کنید]] , back, true)
elseif msg.text:lower() == '15000 سکه' and to == 'main' then
return send_key(msg.from.id, [[برای خرید 15000 سکه از لینک زیر استفاده کنید ]] , back, true)
elseif msg.text:lower() == 'خرید گروه' and to == 'main' then
nerkh = {{"گروه یک ماهه 5000 هزار تومن",'گروه سه ماهه 10000 هزار تومن'},{'گروه ناحدود 15000 هزار تومن'},{'بازگشت به منوی اصلی'}}
local back = {{'بازگشت به منوی اصلی'}}
return send_key(msg.from.id, 'یکی از گزینه های زیر رو انتخواب کنید', nerkh, true)
elseif msg.text:lower() == 'گروه یک ماهه 5000 هزار تومن' and to == 'main' then
return send_key(msg.from.id, [[برای خرید گروه یک ماهه روی لینک زیر کلیک کنید و پس از پرداخت لینک گروه خود را بفرستید]] , back, true)
elseif msg.text:lower() == 'گروه سه ماهه 10000 هزار تومن' and to == 'main' then
return send_key(msg.from.id, [[برای خرید گروه سه ماهه روی لینک زیر کلیک کنید و پس از پرداخت لینک گروه خود را بفرستید]] , back, true)
elseif msg.text:lower() == 'گروه ناحدود 15000 هزار تومن' and to == 'main' then
return send_key(msg.from.id, [[برای خرید گروه نامحدود روی لینک زیر کلیک کنید و پس از پرداخت لینک گروه خود را بفرستید]] , back, true)
elseif msg.text:lower() == 'زیر مجموعه' and to == 'main' then
    local link = '[https://t.me/NfsHelperBot?start='..msg.from.id..']'
    local users = tonumber(db:get('point:'..msg.chat.id))
return send_key(msg.from.id, [[تعداد زیر مجموعه های شما هم اکنون
]]..' '..users..[[ می باشد
برای دریافت گروه شما نیاز به 50 نفر عضو دارید
تعداد باقی مانده ]]..(50-users)..' \nلینک شما\n'..link..'\n*Power by Botnex*' , mkey, true)
elseif to == 'active_group' then
    local data = load_data("data/config.lua")
if not data.token[msg.text] then
return send_key(msg.from.id, 'توکنت غلط است دوباره بفرست', {{'بازگشت به منوی اصلی'}}, true)
       elseif data.token[msg.text] then
    local gp = tonumber(data.token[msg.text])
users[userid].tlist[msg.text] = gp
local gp_data = load_data('data/' .. gp .. '/' .. gp .. '.lua')
if not gp_data.owners[msg.from.id] then
return send_key(msg.from.id, 'شما مدیر گروه نمی باشید', {{"ورود به پنل مدیریتی گروه"},{'دریافت گروه رایگان','راهنما'},{'پشتبانی'}}, true)
end
db:hset('step',msg.from.id,'os_panl')
db:hset('gp',msg.from.id,gp)
return send_key(msg.from.id, 'گروه شما با موفقیت افزوده شد', panl, true)
end
       elseif to == 'os_panl' then
if msg.text == '🔙' then
db:hset('step',msg.from.id,'os_panl')
return send_key(msg.from.id, 'پنل شما', panl, true)
end
    local gp = db:hget('gp',msg.from.id)
if msg.text == 'تنظیمات' then
local data = load_data("data/"..gp.."/"..gp..".lua")
db:hset('step',msg.from.id,'chose_lock')
send_key(msg.from.id, 'یکی از تنظیمات رو انتخاب کنید', doKeyboard_settings(data,gp), true)
return 
elseif msg.text == 'پاک کردن' then

       db:hset('step',msg.from.id,'clean_mod')
	   
         return send_key(msg.from.id, 'چیزی که می خوای پاک شه رو انتخاب کن', {{'میوت لیست','بن لیست'},{'مدیر ها','معاون ها'},{'ربات ها'},{'🔙'}}, true)
        
          elseif msg.text == 'خاموشن کردن گروه' then
   db:hset('step',msg.from.id,'mute_day')
return send_key(msg.from.id, 'گزینه مورد نظرخود را انتخواب کنید', {{'بله'},{'خیر'},{'🔙'}}, true)
elseif msg.text == 'بله' then
local chat_db = 'data/' .. gid .. '/' .. gid .. '.lua'
local data = load_data("data/"..gp.."/"..gp..".lua")
data.lock.all = 'yes'
        save_data(data, chat_db)
elseif msg.text == 'خیر' then
local chat_db = 'data/' .. gid .. '/' .. gid .. '.lua'
local data = load_data("data/"..gp.."/"..gp..".lua")
data.lock.all = 'no'
        save_data(data, chat_db)
          elseif msg.text == 'لیست مدیران' then
       local data = load_data("data/"..gp.."/"..gp..".lua")
       local text = 'لیست مدیران گروه شما \n'
   for k,v in pairs(data.owners) do
   text = text..' *-*'..k..' - *'..v..'*\n'
   end
return send_key(msg.from.id, text, panl, true)
       elseif msg.text == 'دریافت اطلاعات' then
    local data = load_data("data/"..gp.."/"..gp..".lua")
    local text_box = 'لیست اطلاعات گروه شما :\n'
..'  درباره گروه شما : \n'..(data.about or 'no about')..'\n'
..'افراد بن شده : \n'..(#data.banned or 0)..'\n'
..'افراد ساکت شده :\n'..(#data.mute or 0)..'\n'
..'وضعیت خصوصی بودن:\n'..tostring(data.public):gsub('true','بله'):gsub('false','نه')..'\n'
..'لینک گروه : \n'..'['..(data.link or 'موجود نیست')..']'
return send_key(msg.from.id, text_box, panl, true)
       elseif msg.text == 'بازگشت به تنظیمات اولیه' then
    _ = {
        antispam = 'ban',
        banned = {},
		mute = {},
        founded = os.time(),
		flood = {},
        founder = '',
        link = '',
		admin = 0,
		about = 'none',
        settings = {
		arabic = 'ok',
		bot = 'no',
		member = 'no',
		photo = 'yes',
		gif = 'yes',
		video = 'no',
		fwd = 'yes',
		link = 'yes',
		tg = 'no',
		sticker = 'yes',
		},
        moderators = {},
        owners = {[msg.from.id] = '#os test'},
		lang = 'en',
        public = true,
        sticker = 'ok',
        welcome = {
		to = 'group',
         pm = 'wlc to Group',
		}
		,}
save_data(_, 'data/' .. gp .. '/' .. gp .. '.lua')
return send_key(msg.from.id, 'تمامی قفل ها به حالت اول بازگشتند', panl, true)
end
       elseif to == 'clean_mod' then
	   if msg.text == '🔙' then
db:hset('step',msg.from.id,'os_panl')
return send_key(msg.from.id, 'گروه شما با موفقیت افزوده شد', panl, true)
end
    local is_match = msg.text:match('(میوت لیست)') or msg.text:match('(بن لیست)') or msg.text:match('(ربات ها)') or msg.text:match('(معاون ها)') 
if is_match then
if is_match == 'میوت لیست' then mod = 'mute' elseif is_match =='بن لیست' then mod = 'banned' elseif is_match =='ربات ها' then  mod = 'bot' elseif is_match =='معاون ها' then mod = 'owners' end
end
    local gp = db:hget('gp',msg.from.id)
    local data = load_data("data/"..gp.."/"..gp..".lua")
data[mod] = {}
save_data(data, 'data/' .. gp .. '/' .. gp .. '.lua')
db:hset('step',msg.from.id,'os_panl')
return send_key(msg.from.id, 'با موفقیت پاک شدند', panl, true)
elseif to == 'get_gp' then 
local matcher = msg.text:match("(https://telegram.me/joinchat/%S+)") or msg.text:match("(https://t.me/joinchat/%S+)")
if matcher then
--db:hset('step',msg.from.id,'get_gp_id')
send_key(269783122, matcher, {{'بازگشت به منوی اصلی'}}, true)
send_key(msg.from.id, 'شما برنده روه ماشدید\nلطفا شماره خود را به اشتراک بگذارید', {{{text='شماره شما',request_contact=true}},{'بازگشت به منوی اصلی'}}, true)
end
elseif to == 'get_gp_id' then
if not tonumber(msg.text) then
return
end
os.execute('mkdir -p data/' .. tonumber(msg.text))
gpdata = {
        antispam = 'ban',
        banned = {},
		mute = {},
        founded = os.time(),
		flood = {},
        founder = '',
        link =  '',
		admin = 0,
		about = 0,
        lock = {
		arabic = 'ok',
		bot = 'no',
		member = 'no',
		photo = 'yes',
		gif = 'yes',
		video = 'no',
		fwd = 'yes',
		link = 'yes',
		tg = 'no',
		sticker = 'yes',
		},
        moderators = {},
        owners = {[msg.from.id] = '#os test'},
		lang = 'en',
        public = true,
        sticker = 'ok',
        welcome = {
		to = 'group',
		pm = 'wlc to Group',
		},}
		
save_data(gpdata, 'data/' ..  tonumber(msg.text) .. '/' ..  tonumber(msg.text) .. '.lua')
db:hset('step',msg.from.id,'os_panl')
return send_key(msg.from.id, 'در صورت وجود هر مشکل به پشتیبانیی خبر دهید', panl, true)

	   elseif to == 'chose_lock' then
if msg.text == '🔙' then
db:hset('step',msg.from.id,'os_panl')
return send_key(msg.from.id, 'گروه شما با موفقیت افزوده شد', panl, true)
end
local gp = db:hget('gp',msg.from.id)
    local is_lock = msg.text:match('^(fwd)') or msg.text:match('^(video)') or msg.text:match('^(gif)') or msg.text:match('^(member)') or msg.text:match('^(arabic)') or msg.text:match('^(photo)')
	or msg.text:match('^(links)') 
	if is_lock then
db:hset('step',msg.from.id,'edit_lock')
db:hset('chose_lock',msg.from.id,is_lock)
return send_key(msg.from.id, 'لطفا حالت قفل را مشخص کنید', {{'اخطار','حذف','اخراج','مجاز'},{'🔙'}}, true)
end
       elseif to == 'edit_lock' then
if msg.text == '🔙' then
db:hset('step',msg.from.id,'os_panl')
return send_key(msg.from.id, 'برگشت:', panl, true)
end
    local is_match = msg.text:match('(اخطار)') or msg.text:match('(حذف)') or msg.text:match('(اخراج)') or msg.text:match('(مجاز)') 
if is_match then
if is_match == 'اخطار' then mod = 'warn'        elseif is_match == 'حذف' then mod = 'del'        elseif is_match == 'اخراج' then mod = 'kick'        elseif is_match == 'مجاز' then mod = 'no' end
    local gp = db:hget('gp',msg.from.id)
    local lock = db:hget('chose_lock',msg.from.id)
    local data = load_data("data/"..gp.."/"..gp..".lua")
data.lock[lock] = mod
		save_data(data, "data/"..gp.."/"..gp..".lua")
db:hset('step',msg.from.id,'os_panl')
return send_key(msg.from.id, 'تنظیمات اعمال شد', panl, true)
end
end
end
function cron()
    local ctime = db:smembers('ostime')
for i,gp in pairs(ctime) do
    local data = load_data("data/"..gp.."/"..gp..".lua")
if data.muteall < tonumber(os.date("%y%m%d%H%M")) then
    local data = load_data("data/"..gp.."/"..gp..".lua")
data.muteall = nil
save_data(data, "data/"..gp.."/"..gp..".lua")
db:srem('ostime',gp)
return send_key(gp, "`گروه از سوکوت خارج شد`", panl) 
end
end
end 
local function doKeyboard_settings2(chat_id,data)
print('to key')
local chat_id = tostring(chat_id)
    local keyboard = {}
    for media, default_status in pairs(data.lock) do
	local default_status = default_status or 'yes'
        local line = {
            {text = tostring(media), callback_data = 'mediallert:'..chat_id},
            {text = default_status, callback_data = 'media:'..tostring(media)..':'..chat_id}
        }
        table.insert(keyboard, line)
    end
    table.insert(keyboard, {{text = '🔙', callback_data = 'config:back:'..chat_id}})
    print(keyboard)
    return keyboard
end
function get_back(msg)
local text = msg.data
local chat_id = msg.message.chat.id
if text:match('(media):(.*):(.*)') then
print('to locks')
local blocks = {text:match('(media):(.*):(.*)')}
gid  = tonumber(blocks[3])
local chat_db = 'data/' .. gid .. '/' .. gid .. '.lua'
lock = blocks[2] 
if not config.chats.managed[gid] then
answ(msg.id, ' no data ', false)
end
print(gid)
data = load_data("data/"..gid.."/"..gid..".lua")
print(data)
local stats = data.lock[lock] or 'ok'
print(stats)
if stats == 'ok' then
mod = 'del'
elseif stats == 'del' then
mod = 'warn' 
elseif stats == 'warn' then
mod = 'kick'
elseif stats == 'kick' then
mod = 'yes'
elseif stats == 'yes' then
mod = 'ok'
end  
data.lock[lock] = mod
save_data(data,chat_db)
answ(msg.id, lock..' has been changed to '..mod, false)
  editMessageText(msg.from.id, msg.message.message_id, '_'..lock..'_ *has been changed to* _'..mod..'_', true,  doKeyboard_settings2(gid,data))
end
end
function inline(msg , bks)
text = msg.query
print(text)
gp = db:hget('gp',msg.from.id)
if not gp then
tab = {{type = "article",parse_mode = "Markdown",disable_web_page_preview = true,id = "1",title = "شما گروهی تنظیم نکرده اید",description = "اینجا کلیک کنید تا راهنمای اینلاین را دریافت کنید",message_text =  'برای تنظیم گروه به پی ویه ربات مراجعه کنید',},}
return send_req(send_api.."/answerInlineQuery?inline_query_id="..msg.id.."&is_personal=false&cache_time=1&results="..json.encode(tab))
end

if bks[1] == '###nil' then
tab = {{type = "article",parse_mode = "Markdown",disable_web_page_preview = true,id = "1",
title = "راهنمای کار با اینلاین",
description = "برای دریافت راهنما کلیک کنید",
message_text =  'list : برای دریافت لیست ها \nsettings : برای دریافت تنظیمات',},}
end

return send_req(send_api.."/answerInlineQuery?inline_query_id="..msg.id.."&is_personal=false&cache_time=1&results="..json.encode(tab))
end


return {launch = run , cron = cron, inline = inline,call=get_back,
inline_pt = {
'^(###nil)$',
'^(list)$'
}
}