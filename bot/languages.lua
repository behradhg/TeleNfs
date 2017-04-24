local strings = {} -- internal array with translated strings
URL = require "socket.url"
JSON = (loadfile "./libs/dkjson.lua")()

function string:escape_hard(ft)
	if ft == 'bold' then
		return self:gsub('%*', '')
	elseif ft == 'italic' then
		return self:gsub('_', '')
	elseif ft == 'fixed' then
		return self:gsub('`', '')
	elseif ft == 'link' then
		return self:gsub(']', '')
	else
		return self:gsub('[*_`[%]]', '')
	end
end

-- Evaluates the Lua's expression
local function eval(str)
	return load('return ' .. str)()
end

function bk(str)
	return load('return ' .. str)
end

function string:trim() -- Trims whitespace from a string.
	local s = self:gsub('^%s*(.-)%s*$', '%1')
	return s
end 

local function parse(filename)
	local state = 'ign_msgstr' -- states of finite state machine
	local msgid, msgstr
	local result = {}

	for line in io.lines(filename) do
		line = line:trim()
		local input, argument = line:match('^(%w*)%s*(".*")$')
		if line:match('^#,.*fuzzy') then
			input = 'fuzzy'
		end

		assert(state == 'msgid' or state == 'msgstr' or state == 'ign_msgid' or state == 'ign_msgstr')
		assert(input == nil or input == '' or input == 'msgid' or input == 'msgstr' or input == 'fuzzy')

		if state == 'msgid' and input == '' then
			msgid = msgid .. eval(argument)
		elseif state == 'msgid' and input == 'msgstr' then
			msgstr = eval(argument)
			state = 'msgstr'
		elseif state == 'msgstr' and input == '' then
			msgstr = msgstr .. eval(argument)
		elseif state == 'msgstr' and input == 'msgid' then
			if msgstr ~= '' then result[msgid:gsub('^\n', '')] = msgstr end
			msgid = eval(argument)
			state = 'msgid'
		elseif state == 'msgstr' and input == 'fuzzy' then
			if msgstr ~= '' then result[msgid:gsub('^\n', '')] = msgstr end
			if not config.allow_fuzzy_translations then
				state = 'ign_msgid'
			end
		elseif state == 'ign_msgid' and input == 'msgstr' then
			state = 'ign_msgstr'
		elseif state == 'ign_msgstr' and input == 'msgid' then
			msgid = eval(argument)
			state = 'msgid'
		elseif state == 'ign_msgstr' and input == 'fuzzy' then
			state = 'ign_msgid'
		end
	end
	if state == 'msgstr' and msgstr ~= '' then
		result[msgid:gsub('^\n', '')] = msgstr
	end

	return result
end

local locale = {} -- table with exported functions

locale.language = 'en' -- default language

function locale.init(directory)
	directory = directory or "languages"

	for lang_code in pairs(config.available_languages) do
		strings[lang_code] = parse(string.format('%s/%s.po', directory, lang_code))
	end
end

function locale.yandex(lang , text)
if config.yandex then
local base = 'https://translate.yandex.net/api/v1.5/tr.json/translate?'
local key = 'trnsl.1.1.20170311T141713Z.3a91dbd0a344703d.aab83ca14bed666e712ff6166bb699440057b113'
if not key then
return text
end
local url = base..'key='.. key ..'&text=' ..URL.escape(text:escape_hard()) .. '&lang=' .. lang
local dat, code = performRequest(url)
local tab = JSON.decode(dat)
return tab.text[1]
end
return text
end

function locale.translate(msgid)
local b = function()
	if locale.language ~= 'en' then
	return locale.yandex(locale.language , msgid)
	else
	print('wtf')
	return msgid
	end
	end
	print(msgid , locale.language)
	return strings[locale.language][msgid:gsub('^\n', ''):escape_hard()] or b()
end

_ = locale.translate

locale.init()

return locale