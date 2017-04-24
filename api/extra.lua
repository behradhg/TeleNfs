local json = require('dkjson')
local url = require('socket.url')
local http = require('socket.http')
local https = require('ssl.https')
function send_req(url)
	local dat, res = https.request(url)
	local tab = json.decode(dat)
	if res ~= 200 then return false end
	if not tab.ok then
		print(tab.description)
		return false
	end
	return tab
end
function is_ch(uid)
local ch = '@MaXTeamCh'
	local send = send_api.."/getChatMember?chat_id="..ch..'&user_id='..uid
	return send_req(send)
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