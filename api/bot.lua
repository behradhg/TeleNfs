package.path = package.path..';.luarocks/share/lua/5.2/?.lua;.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath..';.luarocks/lib/lua/5.2/?.so'
http = require('socket.http')
https = require('ssl.https')
--[[rd = require('redis') 
db = rd.connect('127.0.0.1', 6379)]]
db = (loadfile "./libs/redis.lua")()
redis = (loadfile "./libs/redis.lua")()
url = require('socket.url')
json = require('dkjson')
serpent = require('serpent')
config = loadfile('./data/config.lua')()
api = dofile('./bot/api.lua')
HELP = loadfile('help.lua')()
send_api = "https://api.telegram.org/bot"..config.api.token
bot_version = "2.5"
sudo_id = config.bot_owner
function vp(value)
  print(serpent.block(value, {comment=false}))
end

function bot_run() 
	bot = nil
	while not bot do
		bot = send_req(send_api.."/getMe")
	end
	plugins = {}
	bot = bot.result
	local runlog = bot.first_name.." [@"..bot.username.."]\nis run in: "..os.date("%F - %H:%M:%S")
	print(runlog)
	send_msg(config.bot_owner, runlog)
	
	for k,v in pairs(config.helper_plugins) do
	 print("Loading plugin", v)
        local ok, err = pcall(function()
            local t = dofile("./plugins/"..v..'.lua')
            plugins[v] = t
        end)
        if not ok then
            print('\27[31mError loading plugin '..v..'\27[39m')
            print('\27[31m'..err..'\27[39m')
        end 
	end
	
	last_update = last_update or 0
	last_cron = last_cron or os.time()
	startbot = true
end

function is_ch(uid)
local ch = '@botnexbot'
	local send = send_api.."/getChatMember?chat_id="..ch..'&user_id='..uid
	return send_req(send)
end
function send_req(url)
local dat,code = https.request(url)
	if not dat then
	send_msg(config.bot_owner, '#request_err.Url : '..url..'\nDesc : Not Desc\nCode : '..code)
	return false, code 
	end
	local tab = json.decode(dat)
	if not tab.ok then
			send_msg(config.bot_owner, '#request_err.Url : '..url..'\nDesc : \n'..tab.description..'\nCode : '..tab.error_code)
return false, tab.description
	end
	return tab
end

function bot_updates(offset)
	local url = send_api.."/getUpdates?timeout=10"
	if offset then
		url = url.."&offset="..offset
	end
	return send_req(url)
end

function load_data(filename)
  if not filename then
    _data = {}
  else
    _data = loadfile(filename)()
  end
  return _data
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



function send_msg(chat_id, text, use_markdown)
	local text_len = string.len(text)
	local num_msg = math.ceil(text_len / 3000)
	if num_msg <= 1 then
		local send = send_api.."/sendMessage?chat_id="..chat_id.."&text="..url.escape(text).."&disable_web_page_preview=true"
		if use_markdown then
			send = send.."&parse_mode=Markdown"
		end
		return send_req(send)
	else
		text = text:gsub("*","")
		text = text:gsub("`","")
		text = text:gsub("_","")
		local f = io.open("large_msg.txt", 'w')
		f:write(text)
		f:close()
		local send = send_api.."/sendDocument"
		local curl_command = 'curl -s "'..send..'" -F "chat_id='..chat_id..'" -F "document=@large_msg.txt"'
		return io.popen(curl_command):read("*all")
	end
end

function send_document(chat_id, name)
	local send = send_api.."/sendDocument"
	local curl_command = 'curl -s "'..send..'" -F "chat_id='..chat_id..'" -F "document=@'..name..'"'
	return io.popen(curl_command):read("*all")
end

function send_key(chat_id, text, keyboard, resize, mark)
	local response = {}
	response.keyboard = keyboard
	response.resize_keyboard = resize
	response.one_time_keyboard = false
	response.selective = false
	local responseString = json.encode(response)
	if mark then
		sended = send_api.."/sendMessage?chat_id="..chat_id.."&text="..url.escape(text).."&disable_web_page_preview=true&reply_markup="..url.escape(responseString)
	else
		sended = send_api.."/sendMessage?chat_id="..chat_id.."&text="..url.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..url.escape(responseString)
	end
	return send_req(sended)
end
function string:split(sep)
	local sep, fields = sep or ":", {}
	local pattern = string.format("([^%s]+)", sep)
	self:gsub(pattern, function(c) fields[#fields+1] = c end)
	return fields
end

function send_inline(chat_id, text, keyboard)
	local response = {}
	response.inline_keyboard = keyboard
	local responseString = json.encode(response)
	local sended = send_api.."/sendMessage?chat_id="..chat_id.."&text="..url.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..url.escape(responseString)
	return send_req(sended)
end

function send_photo(chat_id, photo, caption)
	if caption then
		send = send_api.."/sendPhoto?chat_id="..chat_id.."&photo="..photo.."&caption="..url.escape(caption)
	else
		send = send_api.."/sendPhoto?chat_id="..chat_id.."&photo="..photo
	end
	return send_req(send)
end

function send_video(chat_id, video, caption)
	if caption then
		send = send_api.."/sendVideo?chat_id="..chat_id.."&video="..video.."&caption="..url.escape(caption)
	else
		send = send_api.."/sendVideo?chat_id="..chat_id.."&video="..video
	end
	return send_req(send)
end

function send_audio(chat_id, audio, title, caption)
	if caption then
		send = send_api.."/sendAudio?chat_id="..chat_id.."&audio="..audio.."&title="..url.escape(title).."&performer="..url.escape(caption)
	else
		send = send_api.."/sendAudio?chat_id="..chat_id.."&audio="..audio.."&title="..url.escape(title)
	end
	return send_req(send)
end

function send_doc(chat_id, document, caption)
	if caption then
		send = send_api.."/sendDocument?chat_id="..chat_id.."&document="..document.."&caption="..url.escape(caption)
	else
		send = send_api.."/sendDocument?chat_id="..chat_id.."&document="..document
	end
	return send_req(send)
end
	
function mem_num(chat_id)
	local send = send_api.."/getChatMembersCount?chat_id="..chat_id
	return send_req(send)
end

function channel(chat_id)
	local send = send_api.."/getChat?chat_id="..chat_id
	return send_req(send)
end

function ch_admins(chat_id)
	local send = send_api.."/getChatAdministrators?chat_id="..chat_id
	return send_req(send)
end

function mem_info(chat_id, user_id)
	local send = send_api.."/getChatMember?chat_id="..chat_id.."&user_id="..user_id
	return send_req(send)
end

function kickme(chat_id)
	local send = send_api.."/leaveChat?chat_id="..chat_id
	return send_req(send)
end
function string:input()
	if not self:find(' ') then
		return false
	end
	return self:sub(self:find(' ')+1)
end

function msg_receive(msg)
	if msg.date < os.time() - 5 then return end
	if msg.text then
		for name,plugin in pairs(plugins) do
		if plugin.launch then
		print('os text msgs :', name)
		print('msg match :', msg.text)
        plugin.launch(msg)
		end
		end
end
	end


function query_receive(msg)
	for name,plugin in pairs(plugins) do
		if plugin.inline then
		text = msg.query
		if text == '' then
		text = '###nil'
		end
        for k, pattern in pairs(plugin.inline_pt) do
    local matches = match_pattern(pattern, text)
    if matches then
		print('os inline msgs :', name)
        return plugin.inline(msg ,matches)
		end
		end
end
end
end
function editMessageText(chat_id, message_id, text, parse_mode, keyboard)
	local send = send_api .. '/editMessageText?chat_id=' .. chat_id .. '&message_id='..message_id..'&text=' .. url.escape(text)
	if parse_mode then
		if type(parse_mode) == 'string' and parse_mode:lower() == 'html' then
			send = send .. '&parse_mode=HTML'
		else
			send = send .. '&parse_mode=Markdown'
		end
		
	end
	send = send .. '&disable_web_page_preview=true'
	if keyboard then
	local response = {}
	response.inline_keyboard = keyboard
	local responseString = json.encode(response)
    url.escape(responseString)
	send = send..'&reply_markup='..url.escape(responseString)
	end
	return send_req(send)
end

function editinlineText(message_id, text, parse_mode, keyboard)
	local send = send_api .. '/editMessageText?inline_message_id=' ..  message_id .. '&text=' .. url.escape(text)
	if parse_mode then
		if type(parse_mode) == 'string' and parse_mode:lower() == 'html' then
			send = send .. '&parse_mode=HTML'
		else
			send = send .. '&parse_mode=Markdown'
		end
		
	end
	send = send .. '&disable_web_page_preview=true'
	if keyboard then
	local response = {}
	response.inline_keyboard = keyboard
	local responseString = json.encode(response)
    url.escape(responseString)
	send = send..'&reply_markup='..url.escape(responseString)
	end
	return send_req(send)
end

function answ(callback_query_id, text, show_alert, cache_time)
	local url = send_api .. '/answerCallbackQuery?callback_query_id=' .. callback_query_id .. '&text=' .. url.escape(text)
	if show_alert then
		url = url..'&show_alert=true'
	end
	
	if cache_time then
		local seconds = tonumber(cache_time) * 3600
		url = url..'&cache_time='..seconds
	end

	return send_req(url)
	 
end

function sendChatAction(chat_id, action)
 -- Support actions are typing, upload_photo, record_video, upload_video, record_audio, upload_audio, upload_document, find_location

	local url = send_api .. '/sendChatAction?chat_id=' .. chat_id .. '&action=' .. action
	return send_req(url)

end
function match_pattern(pattern, text, lower_case)
    if text then
        local matches = {}
        if lower_case then
            matches = { string.match(text:lower(), pattern) }
        else
            matches = { string.match(text, pattern) }
        end
        if next(matches) then
            return matches
        end
    end-- nil
end


function match_plugin(msg, plugin, plugin_name)
print('on callback_query msgs ; ', msg.data)
  for k, pattern in pairs(plugin.triggers) do
    local matches = match_pattern(pattern, msg.data)
    if matches then
	print('msgs match : ', pattern)
      if plugin.call then
local success, result = xpcall(plugin.call, debug.traceback, msg, matches)       
if not success then --if a bug happens

print(result)  
end
      end
    end
  end
end 


function callback_query(msg)
if msg.message then
ch_i = msg.message.chat.id
else
ch_i = msg.from.id
end
locale.language = redis:get('lang:'..ch_i) or 'en'


		for name,plugin in pairs(plugins) do
		if plugin.triggers then
        match_plugin(msg, plugin, name)
		end
    end
	
end
bot_run()
locale = require('./bot/languages')

while startbot do
	local res = bot_updates(last_update+1)
	if res then
		for i,v in ipairs(res.result) do
			last_update = v.update_id

			if v.edited_message then
			msg_receive(v.edited_message)
			elseif v.message then
			msg_receive(v.message)
			elseif v.inline_query then
			query_receive(v.inline_query)
		    elseif v.callback_query then
			callback_query(v.callback_query)
			end
		end
	else
	end
end