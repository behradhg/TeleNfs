# start nfs source project.
package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'
print('\27[1mLoading lua :\27[0;39;49m',_VERSION)
local f = assert(io.popen('/usr/bin/git describe --tags', 'r'))
VERSION = assert(f:read('*a'))
	  my = {}
	  my.time = {}
	  my.time.Parameter = {
	  ['key'] = "KHNG1F4FI9WB", -- put your key here
	  ['format'] = "json",
	  ['by'] = "zone",
	  ['zone'] = "Asia/Tehran",
	  }

f:close()
chats = {}
local last_cron
warn_time = {}
local lgi = require ('lgi')
local notify = lgi.require('Notify')
notify.init ("Telegram updates")
require("./bot/utils") 
function getMe(cb,cmd) 
tdcli_function ({ID = "GetMe",}, cb, cmd) 
end

function up_time()
  local url = "http://api.timezonedb.com/v2/get-time-zone?"
for i , i_val in pairs(my.time.Parameter) do
		url = url.. i .. '=' .. i_val .. '&'
end
	  local dat , suc = performRequest(url)
	  local tab = JSON.decode(dat)
	  local x = tab.formatted:split(' ')
	  local y = x[2]:split(':')
	  my.time.h = y[1]
	  my.time.m = y[2]
	  my.time.s = y[3]
end

function do_bot(arg, data)
 bot = {id = data.id_}
 end
function tdcli_update_callback(data)  -- Get some msg
if not started then
print('bot is not started')
    return
end
  a = 0
  while not bot do
  a = a + 1
  getMe(do_bot)
  if a > 5 then
  break
  end
  end

  if not data.date_ then
  data.date_ = os.time()
  end  
  

  if data.date_ - 5 > os.time() then -- old msg 
  return false
  end 
  
      if (data.ID == "UpdateMessageContent") then -- do plugins with edited msg :|
	      up_time()

	  print('match edit msgs')
	  td.getMessage(data.chat_id_, data.message_id_,function(a , b)
	  msg = edit_tg(b)
	  if msg then
	  tdcli_function ({ID = "GetUser",user_id_ = msg.from.id}, user_callback, msg)
	  end
	  end
	  )
      return  pre_process_edit(data)
	  end

	  if (data.ID == "UpdateNewMessage") then
	      up_time()
	local data = pre_process_msg(data)
	Data = data   -- to save new tg tables
	local username = export_username(data)

	if not data then -- do pre_process_msg
	return
	end
    
 local msgb = data.message_
    if msgb.content_.ID == "MessageText" then
msg = oldtg(data)

if msg.from.id == bot.id then
return print('not vaild : msg from us')
end
tdcli_function ({ID = "GetUser",user_id_ = data.message_.sender_user_id_}, user_callback, msg)
end
end
if last_cron ~= os.date('%M') then
	      up_time()
    last_cron = os.date('%M')
    for name, plugin in pairs(plugins) do
      if plugin.cron then -- Call each plugin's cron function, if it has one.
	  print('\27[1mCorn update :\27[0;39;49m',name)
		local res, err = pcall(plugin.cron)
				if not res then
print(err)
				return
					end
      end
    end
  end
end


function sleep(s) 
  local ntime = os.time() + s  
  td.sendChatAction(msg.to.id, 'Typing')
 while ntime > os.time() do
  
  end
end

function export_username(msg) -- N~F~S!v2
if not msg then
return
end
if msg.message_.content_.ID == "MessageChatAddMembers" then -- best saver 

local mgs = msg.message_.content_.members_
for i = 0,#msg.message_.content_.members_ do
local uid = mgs[i].id_
local uname = mgs[i].username_
 
if uname then
config.username[uid] = uname
save_config()
end
end
return 'done'
end

if msg.message_.sender_user_id_ then
td.getUser(msg.message_.sender_user_id_, save_username,{user = msg.message_.sender_user_id_})
end

end


function get_uname(uid)
local uname = config.username[uid]
td.getUser(uid, save_username,{user = uid})
if uname then
return '@'..uname..' ['..uid..']'
else
td.getUser(uid, save_username,{user = uid})
return uid
end
end


function save_username(extra,msg)
if msg.username_ then
config.username[extra.user] = msg.username_
save_config()
else
return
end
end


function do_notify (user, msg)
    local n = notify.Notification.new(user, msg)
    n:show ()
end

function dl_cb(arg, data)

end

function set_copy()
text = '\n-- (C) 2016-17 Nfs source; MIT License'
local plugs = scandir('./plugins')
for k,v in pairs(plugs) do
local last_file = io.open("./plugins/"..v..".lua", "r")
local text = last_file:read("*all")..text
local file = io.open("./plugins/"..v..".lua", "w")
file:write(text)
file:flush()
file:close()
end
end
-- set_copy()
function create_config()
local x_sudo
  prterr('\n Some functions and plugins using bot owner as managed bot.\n'
      .. ' Please provide bot owner user id to ensure it\'s works as intended.\n'
      .. ' You can ENTER to skip and then fill the required info into ' .. config_file .. '\n')
  io.write('\27[1m Input your ID  here: \27[0;39;49m')
  local x_sudo = io.read()

  _config = {
  cmd = '[!/#]',
  yandex = true,
  lower_text = true,
  api_key = {
      bing_url = 'https://datamarket.azure.com/dataset/bing/search',
      bing = '',
      forecast_url = 'https://developer.forecast.io/',
      forecast = '',
      globalquran_url = 'http://globalquran.com/contribute/signup.php',
      globalquran = '',
      muslimsalat_url = 'http://muslimsalat.com/panel/signup.php',
      muslimsalat = '',
      nasa_api_url = 'http://api.nasa.gov',
      nasa_api = '',
      thecatapi_url = 'http://thecatapi.com/docs.html',
      thecatapi = '',
      yandex_url = 'http://tech.yandex.com/keys/get',
      yandex = '',
    },
	globally_banned = {},
    mkgroup = {founded = '', founder = '', title = '', gtype = '', uid = ''},
    realm = {},
    administration = {},
    administrators = {},
    api = {
      master = our_id
    },
	username = {},
    autoleave = false,
	disabled_channels = {},
    disabled_plugin_on_chat = {},
    chats = {disabled = {}, managed = {}, realm = {}},
    key = {},
	bot_owner = x_sudo,
    language = 'en',
	available_languages = {
	['en'] = 'English',
	['fa'] = 'فارسی'
	},
		token = {},
    enabled_plugins = {"gpmod","plugins","active","boobs","callback","clac","expire","extra","help","sudo","id","imdb","inpm"
	,"msg_cheack","pin","report","setlang","vip","write"},
	helper_plugins = {"help","callback","helper","boobs","write","settings"},
    sudo_users = {[206637124] = 206637124}
	}

  save_data(_config, config_file)
end

local curl = require 'cURL'
local URL = require 'socket.url'
local JSON = require 'dkjson'
local clr = require 'term.colors'
local curl_context = curl.easy{verbose = false}


function performRequest(url)
	local data = {}
	
	-- if multithreading is made, this request must be in critical section
	local c = curl_context:setopt_url(url)
		:setopt_writefunction(table.insert, data)
		:perform()

	return table.concat(data), c:getinfo_response_code()
end

function sendRequest(url)
	local dat, code = performRequest(url)
	local tab = JSON.decode(dat)

	if not tab then
		print(clr.red..'Error while parsing JSON'..clr.reset, code)
		print(clr.yellow..'Data:'..clr.reset, dat)
		api.sendAdmin(dat..'\n'..code)
		--error('Incorrect response')
	end

	if code ~= 200 then
		
		if code == 400 then
			 --error code 400 is general: try to specify
			 code = tab.description
		end
		
		print(clr.red..code, tab.description..clr.reset)
		redis:hincrby('bot:errors', code, 1)
		
		return false, code, tab.description
	end
	
	if not tab.ok then
		api.sendAdmin('Not tab.ok')
		return false, tab.description
	end
	
	return tab

end

function get_Me(t)
    local BASE_URL = 'https://api.telegram.org/bot'..t
	local url = BASE_URL .. '/getMe'
	return sendRequest(url)

end

function api_getme()
  prterr('\n Some functions and plugins using bot API as sender.\n'
      .. ' Please provide bots API token to ensure it\'s works as intended.\n'
      .. ' You can ENTER to skip and then fill the required info into ' .. config_file .. '\n')

  io.write('\27[1m Input your bot API key (token) here: \27[0;39;49m')

  local config = loadfile(config_file)()
  local bot_api_key = io.read()
  config.api.token = bot_api_key
  local test = get_Me(bot_api_key)
  if test then
  botid = test.result
  end
  if not botid then
  print('token is false')
  exit()
  end
  config.api.token = bot_api_key
  config.api.id = botid.id
  config.api.first_name = botid.first_name
  config.api.username = botid.username
  save_data(config, config_file)
end

function match_plugin(msg, plugin, plugin_name)
locale.language = redis:get('lang:'..msg.to.id) or 'en' --group language
  for k, pattern in pairs(plugin.patterns) do
    local matches = match_pattern(pattern, msg.text , config.lower_text, true)
    if matches then
	if not is_sudo(msg.from.peer_id) and warn_time[msg.from.id] and os.difftime(os.time() ,warn_time[msg.from.id]) < 5 then
return reply_msg(msg.id, _('Your are flooding on send the comamnds time between 5 second'), ok_cb, true)
end	
	warn_time[msg.from.id] = os.time()
      print('msg matches: ', pattern)
      if is_plugin_disabled_on_chat(plugin_name, get_receiver(msg)) then
        return nil
      end
      if plugin.run then
local success, result = xpcall(plugin.run, debug.traceback, msg, matches) 
					if not success then --if a bug happens
	               reply_msg(msg.id, '#bug_finder NFS\n🐞 Sorry, a bug occurred', ok_cb, true)
					api.sendMessage(config.bot_owner,'#bug finder\n'..tostring(result), nil, nil, nil, nil, nil)
							return
						end
			if result then
			send_large_msg(get_receiver(msg), result)
			elseif not result then
			
          end
        
      end
    end
  end
end

function match_plugins(msg)
  for name, plugin in pairs(plugins) do
    match_plugin(msg, plugin, name)
  end
end

function save_config()
  save_data(_config, config_file)
end

function load_config()
    print('\n\27[1;33m welcome to Nfs-bot.\n'
       .. ' Please run bot with scripts, then restart bot.\27[0;39;49m\n') 
	if not file_exists(config_file) then
    print(' Created new config file: ' .. config_file)
    create_config()
	print(' Created new bot config data : ' .. config_file)
	api_getme()
  end
  local config = loadfile(config_file)()
 if config.bot_owner then
 print('\27[1m Bot owner : ' .. config.bot_owner .. ' \27[0;39;49m')

 end

  for v,user in pairs(config.sudo_users) do
	print('\27[1m Sudo user : ' .. user .. ' \27[0;39;49m')
  end

  return config
end
_config = load_config()
config = _config
api = dofile('./bot/api.lua')

 function init_bot()
  for k,v in pairs(_config.api) do
  print('\27[1;33m '..k..'\27[0;39;49m',v) 
  end
  api.sendMessage(config.bot_owner, '*Bot started!*\n_'..os.date('On %A, %d %B %Y\nAt %X')..'_\n'..#config.enabled_plugins..' plugins loaded', 'markdown', nil, nil, nil, nil)
 end
 
 init_bot()

function load_plugins()

    for k, v in pairs(_config.enabled_plugins) do
        print("\27[1m Loading plugin : "..v.."\27[0;39;49m")
        local ok, err = pcall(function()
            local t = dofile("./plugins/"..v..'.lua')
            plugins[v] = t
        end)
        if not ok then
            print('\27[31mError loading plugin '..v..'\27[39m')
            print('\27[31m'..err..'\27[39m')

        end 
    end
end
plugins = {}
load_plugins()
locale = require('./bot/languages')

function msg_valid(msg)
    -- Don't process outgoing messages
    if msg.from.id == 0 then
        print('\27[36mNot valid: msg from us\27[39m')
        return false
    end

    -- Before bot was started
    if msg.date < now then
        print('\27[36mNot valid: old msg\27[39m')
        return false
    end

    if msg.unread == 0 then
        print('\27[36mNot valid: readed\27[39m')
        return false
    end
	
    if msg.from.peer_id == tonumber(_config.api.id) then
    prterr('Not valid: Msg from our companion bot')
    return false
    end
  
    if not msg.to.id then
        print('\27[36mNot valid: To id not provided\27[39m')
        return false
    end

    if not msg.from.id then
        print('\27[36mNot valid: From id not provided\27[39m')
        return false
    end

    if msg.from.id == 777000 then
        print('\27[36mNot valid: Telegram message\27[39m')
        return false
    end

    return true
end
send_api = "https://api.telegram.org/bot"..config.api.token
function bot_init(msg)
    receiver = msg.to.id
    if _config.our_id == msg.from.id then
        msg.from.id = 0
    end
    if msg_valid(msg) then
        if msg then
            match_plugins(msg)
        end
    end

end

function pre_process_msg(msg)

if bot and msg.message_.sender_user_id_ == bot.id then
return print('not vaild : msg from us')
end

    for name,plugin in pairs(plugins) do
        if plugin.pre_process and msg then
            print('Preprocess', name)
            msg = plugin.pre_process(msg)
        end
    end
    return msg
end

function pre_process_edit(msg)
    for name,plugin in pairs(plugins) do
        if plugin.on_edit_msg and msg then
            print('on_edit_msg', name)
            msg = pcall(plugin.on_edit_msg,msg)
        end
    end
    return msg
end

function write_help()  -- for nfs base
local help = {}
for name,plugin in pairs(plugins) do
if plugin.usage then
help[name] = {}
help[name].description = (plugin.description or nil)
help[name].usage = plugin.usage
end
end

local file = io.open("help.lua", "w")
serialized = serpent.block(help, {comment = false,indent = '     ', sortkeys = false,name = 'help'})
file:write(serialized)
file:flush()
file:close()
return help
end

HELP = write_help()
function user_callback(msg, message)
    msg = user_data(msg, message)
    bot_init(msg)
    
end

started = true
our_id = 0
now = os.time()
math.randomseed(now)
print('bot down')




