local curl = require 'cURL'
local URL = require 'socket.url'
local JSON = require 'dkjson'
local clr = require 'term.colors'

  local function getRandomBootts(attempt, bootts)
    attempt = attempt or 0
    attempt = attempt + 1
    local count = bootts == 'butts' and 3 or 10
    local url = string.format('http://api.o%s.ru/noise/1', bootts)
    local res, status = performRequest(url)

    if status ~= 200 then return nil end
    local data = JSON.decode(res)[1]

    
    if not data and attempt < count then
      print('Cannot get that %s, trying another one...'):format(bootts)
      return getRandomBootts(attempt, bootts)
    end
    local output = string.format('http://media.o%s.ru/%s', bootts, data.preview)
    return output
  end

--------------------------------------------------------------------------------

  local function run(msg, matches)
  
    local url = getRandomBootts(nil, matches[1])
    if url ~= nil then
    td.sendText(msg.to.id, msg.id, 1, 0, nil,url, 0, 'html', ok_cb, bk)

    else
      local text = 'Error getting boobs/butts for you, please try again later.'
     reply_msg(msg.id, text, ok_cb, true)
    end
  end

  local function inline(msg , matches)

  if matches[1] == 'blist' then
  local tab = load_data('xxx.lua')
  local box = {}
  local a = 1
  for x=1 ,20 do
    getRandomBootts(attempt, 'boobs')
  local v =  tab.boobs[math.random(#tab.boobs)]
  table.insert(box,{type = "photo",photo_url = v,id = tostring(a),thumb_url = v,})
  a = a + 1
  end
  print(#tab.boobs)
  return send_req(send_api.."/answerInlineQuery?inline_query_id="..msg.id.."&is_personal=false&cache_time=1&results="..json.encode(box))
end
   local url = getRandomBootts(nil, matches[1])
   print(matches[1])
   if url ~= nil then
   tab = {{type = "photo",photo_url = url,id = "1",
title = "دریافت عکس",
description = "دریافت عکس",
thumb_url = url,},}
else
local text = 'Error getting boobs/butts for you, please try again later.'
tab = {{type = "article",disable_web_page_preview = true,id = "1",
title = "eror",
description = text,
message_text =  text,},}
end
return send_req(send_api.."/answerInlineQuery?inline_query_id="..msg.id.."&is_personal=false&cache_time=1&results="..json.encode(tab))
end
--------------------------------------------------------------------------------

  return {
    description = 'Gets a random boobs or butts pic',
    usage = {
        '<code>!boobs</code>',
        'Get a boobs NSFW image. ',
        '',
        '<code>!butts</code>',
        'Get a butts NSFW image.',
        '',
      
    },
    patterns = {
      '(boobs)$',
      '(butts)$'
    },
	inline_pt = {
     '(boobs)',
     '(butts)',
     '(blist)'
     },
    run = run,
	inline = inline
  }
