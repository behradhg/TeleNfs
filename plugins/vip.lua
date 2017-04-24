
-------------------------------------
local function run_bash(str)
  local cmd = io.popen(str)
  local result = cmd:read('*all')
  cmd:close()
  return result
end

-------------------------------------
function is_vip(gid , uid)
if is_sudo(uid) then
return true
end
if redis:sismember('viphash' , gid) then
return true
end
return false

end


  ----------------------
local  function lua(str)
  local output = loadstring(str)()
  if output == nil then
    output = ''
  elseif type(output) == 'table' then
    output = 'Done! Table returned.'
  else
    output = ""..tostring(output)
  end
  return output
end

local function get_weather(location)
  print("Finding weather in ", location)
  local BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
  local url = BASE_URL
  url = url..'?q='..location..'&APPID=eedbc05ba060c787ab0614cad1f2e12b'
  url = url..'&units=metric'
  local b, c, h = http.request(url)
  if c ~= 200 then return nil end

   local weather = json:decode(b)
   local city = weather.name
   local country = weather.sys.country
   local temp = 'دمای شهر '..city..' هم اکنون '..weather.main.temp..' درجه سانتی گراد می باشد\n____________________'
   local conditions = 'شرایط فعلی آب و هوا : '

   if weather.weather[1].main == 'Clear' then
     conditions = conditions .. 'آفتابی☀'
   elseif weather.weather[1].main == 'Clouds' then
     conditions = conditions .. 'ابری ☁☁'
   elseif weather.weather[1].main == 'Rain' then
     conditions = conditions .. 'بارانی ☔'
   elseif weather.weather[1].main == 'Thunderstorm' then
     conditions = conditions .. 'طوفانی ☔☔☔☔'
 elseif weather.weather[1].main == 'Mist' then
     conditions = conditions .. 'مه 💨'
  end

  return temp .. '\n' .. conditions
end
function run(msg, matches)
    local gid = msg.to.peer_id
    local uid = msg.from.peer_id
--if is_vip_group(msg) then
if matches[1] == 'food' then
local url = "http://lorempixel.com/400/200/food/MaxTeamCh"
local file = download_to_file(url,'test.webp')
td.sendDocument(get_receiver(msg), 0, 0, 1, nil, file)
end
if matches[1] == 'logo' and matches[2] then
local site = matches[2]
 local url = "http://logo.clearbit.com/"..site.."?size=500"
 local randoms = math.random(1000,900000)
 local randomd = randoms..".jpg"
 local file = download_to_file(url,randomd)
td.sendPhoto(get_receiver(msg), 0, 0, 1, nil, file)
end
if matches[1] == 'anime' then
local url = http.request('https://konachan.com/post.json?limit=300')
local js = json:decode(url)
local random = math.random (100)
local sticker = js[random].jpeg_url
local file = download_to_file(sticker,'anime.webp')
td.sendDocument(get_receiver(msg), 0, 0, 1, nil, file)
end
if matches[1] == 'vid' and matches[2] then
local url , res = http.request('http://www.omdbapi.com/?t='..matches[2])
if res ~= 200 then return "No connection" end
local jdat = json:decode(url)
local text = 'Title : '..jdat.Title..'\nYear : '..jdat.Year..'\nRuntime : '..jdat.Runtime..'\nGenre : '..jdat.Genre..'\nLanguage : '..jdat.Language..'\n\n@MaXTeamCh'
local stick = jdat.Poster
local file = download_to_file(stick,'vid.webp')
td.sendDocument(get_receiver(msg), 0, 0, 1, nil, file)
return text
end
if matches[1] == 'voice' and matches[2] then
local url = "http://tts.baidu.com/text2audio?lan=en&ie=UTF-8&text="..matches[2]
  local receiver = get_receiver(msg)
  local file = download_to_file(url,'text.ogg')
      td.sendAudio(get_receiver(msg), 0, 0, 1, nil, file)
end
if matches[1] == 'time' then
local url = http.request('http://api.gpmod.ir/time/')
local jdat = json:decode(url)
 local text =  '🕒 ساعت '..jdat.FAtime..' \n📆 امروز '..jdat.FAdate..' میباشد.\n--\n🕒 '..jdat.ENtime..'\n📆 '..jdat.ENdate
return text
end
if matches[1] == 'tr' and matches[2] and matches[3] then
local htp = https.request('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160119T111342Z.fd6bf13b3590838f.6ce9d8cca4672f0ed24f649c1b502789c9f4687a&format=plain&lang='..URL.escape(matches[2])..'&text='..URL.escape(matches[3]))
local data = json:decode(htp)
return '<code>زبان : '..data.lang..'</code>\n<code>معنی</code> : '..data.text[1]
end
do
if matches[1]:lower() == 'keep' then
local text = URL.escape(matches[2]) -- text
local bc = '1b037d' 
local size = '500'
local tc = 'ffffff'
local style = '%EE%BB%B0%0D%0A'

if matches[3] == '1' then -- styles
style = '%EE%BB%AA%0D%0A'
elseif matches[3] == '2' then
style = '%EE%BB%AB%0D%0A'
elseif matches[3] == '3' then
style = '%EE%BB%AC%0D%0A'
elseif matches[3] == '4' then
style = '%EE%BB%AD%0D%0A'
elseif matches[3] == '5' then
style = '%EE%BB%BD%0D%0A'
elseif matches[3] == '6' then
style = '%EE%BB%B7%0D%0A'
elseif matches[3] == '7' then
style = '%EE%BB%B4%0D%0A'
elseif matches[3] == '8' then
style = '%EE%BB%B1%0D%0A'
elseif matches[3] == '9' then
style = '%EE%BB%AE%0D%0A'
elseif matches[3] == '10' then
style = '%EE%BB%AF%0D%0A'
elseif matches[3] == '11' then
style = '%EE%BB%BC%0D%0A'
elseif matches[3] == '12' then
style = '%EE%BB%B3%0D%0A'
elseif matches[3] == '13' then
style = '%EE%BB%B0%0D%0A'
elseif matches[3] == '14' then
style = '%EE%BB%B2%0D%0A'
elseif matches[3] == '15' then
style = '%EE%BB%BF%0D%0A'
elseif matches[3] == '16' then
style = '%EE%BB%B8%0D%0A'
elseif matches[3] == '17' then
style = '%EE%BB%B9%0D%0A'
elseif matches[3] == '18' then
style = '%EE%BB%BE%0D%0A'
elseif matches[3] == '19' then
style = '%EE%BB%BB%0D%0A'
elseif matches[3] == '20' then
style = '%EE%BB%B6%0D%0A'
elseif matches[3] == '21' then
style = '%EE%BB%BA%0D%0A'
elseif matches[3] == '22' then
style = '%EE%BB%B5%0D%0A'
elseif matches[3] == '23' then
style = '%EE%BC%81%0D%0A'
elseif matches[3] == '24' then
style = '%EE%BC%80%0D%0A'
elseif matches[3] == '25' then
style = '%EE%BC%82%0D%0A'
elseif matches[3] == '26' then
style = '%EE%BC%83%0D%0A'
elseif matches[3] == '27' then
style = '%EE%BC%85%0D%0A'
elseif matches[3] == '28' then
style = '%EE%BC%84%0D%0A'
end

if matches[4] == 'pink' then -- text colors
bc = 'e3068d'
elseif matches[4] == 'green' then

bc = '037d12'
elseif matches[4] == 'blue' then
bc = '1b037d'
elseif matches[4] == 'cyan' then
bc = '0cc0fd'
elseif matches[4] == 'red' then
bc = 'e31f17'
elseif matches[4] == 'yellow' then
bc = 'F7FF03'
elseif matches[4] == 'gold' then
bc = 'd4af37'
elseif matches[4] == 'black' then
bc = '000000'
elseif matches[4] == 'cream' then
bc = 'fffdd0'
elseif matches[4] == 'white' then
bc = 'ffffff'
elseif matches[4] == 'orange' then
bc = 'FF960D' 
end

if matches[5] == 'white' then -- background colors
tc = 'ffffff'
elseif matches[5] == 'pink' then
tc = 'e3068d'
elseif matches[5] == 'green' then
tc = '037d12'
elseif matches[5] == 'blue' then
tc = '1b037d'
elseif matches[5] == 'cyan' then
tc = '0cc0fd'
elseif matches[5] == 'red' then
tc = 'e31f17'
elseif matches[5] == 'yellow' then
tc = 'F7FF03'
elseif matches[5] == 'cream' then
tc = 'fffdd0'
elseif matches[5] == 'gold' then
tc = 'd4af37'
elseif matches[5] == 'black' then
tc = '000000'
elseif matches[5] == 'orange' then
tc = 'FF960D' 
end

if matches[6] == 'small' then -- size
size = '300'
elseif matches[6] == 'medium' then
size = '500'
elseif matches[6] == 'larg' then
size = '700'
end
local base_url = 'http://www.keepcalmstudio.com/-/p.php?t='..style..''..text..'&bc='..bc..'&tc='..tc..'&cc='..tc..'&uc=true&ts=true&ff=PNG&w='..size..'&ps=sq'
local file = download_to_file(base_url,'keep.webp')
td.sendDocument(get_receiver(msg), 0, 0, 1, nil, file)
end
end
if matches[1] == 'weather' then
    city = matches[2]
  local wtext = get_weather(city)
  if not wtext then
    wtext = 'مکان وارد شده صحیح نیست'
  end
  return wtext
end
if matches[1]:lower() == 'mobile' then
local url = http.request("http://www.mobile.ir/phones/AjaxLatestPhonesJson.aspx")
  local jdat = json:decode(url)
  local text2 = ''
  for i = 1 , #jdat do
    text2 = text2..i
    text2 = ''..text2..' >><b> '..jdat[i].title..' </b>'
	text2 = text2..'\nmobile.ir'..jdat[i].url.."\n\n"
    end
reply_msg(msg.id, text2, ok_cb, false)
end
if matches[1] == 'love' then
local url = "http://www.iloveheartstudio.com/-/p.php?t="..matches[2].."%20%EE%BB%AE%20"..matches[3].."&bc=FFFFFF&tc=000000&hc=ff0000&f=c&uc=true&ts=true&ff=PNG&w=500&ps=sq"
 local  file = download_to_file(url,'love.webp')
td.sendDocument(get_receiver(msg), 0, 0, 1, nil, file)
end
---------------------
  if matches[1] == '[$](.*)' and is_sudo(msg.from.peer_id) then
    return run_bash(matches[1])
  end
---------------------
---------------------
  local urlbb = nil

  --[[if matches[1] == "boobs" then
    urlbb = getRandomBoobs()
  end

  if matches[1] == "butts" then
    urlbb = getRandomButts()
  end
  if urlbb ~= nil then
    local receiver = get_receiver(msg)
    send_photo_from_url(receiver, urlbb)
  end]]
--------LUA---------
if matches[1] == "lua" and is_sudo(msg.from.peer_id) then
    return lua(matches[2])
end
 ------------- Git    -------------
        if matches[1] == "git" then
     url = "https://api.github.com/users/"..URL.escape(matches[2])
     jstr, res = https.request(url)
     jdat = JSON.decode(jstr)
  if jdat.message then
     return 'No data found' 
     end
    text = jdat.login..'\nFollowers: '..jdat.followers..'\nFollowings: '..jdat.following..'\nRepos: '..jdat.public_repos..'\nProfile URL: '..jdat.html_url
    file = download_to_file(jdat.avatar_url,'Max.jpg')
    td.sendPhoto(get_receiver(msg), 0, 0, 1, nil, file)
	return text 
end
    ------------- Git User    -------------
  if matches[1] == "gituser" then
     url = "https://api.github.com/repos/"..URL.escape(matches[2]).."/"..URL.escape(matches[3])
     jstr, res = https.request(url)
     jdat = JSON.decode(jstr)
  if jdat.message then
return 'No data found'
end
     text = jdat.owner.login..' / '..jdat.name
  text = text..'\n______________________________\nLanguage: '..jdat.language
  ..'\nForks: '..jdat.forks_count
  ..'\nIssues: '..jdat.open_issues
  ..'\nRepo URL: '..jdat.html_url
   file = download_to_file(jdat.owner.avatar_url,'Max.jpg')
	td.sendPhoto(get_receiver(msg), 0, 0, 1, nil, file)
	return text
end 
    ------------- Git dl    -------------
  if matches[1] == "gitdl" then
       day = os.date("%I")
       hash = 'github:dl:'..day..':'..msg.from.id
       is_github = redis:get(hash)
   if is_github and not is_sudo(msg.from.peer_id) then
      return "After 1Minute request \n(server Busy)"
   elseif not is_github  then
          redis:set(hash, true)
          end
  url = "https://codeload.github.com/"..matches[2]..'/'..matches[3].."/zip/master"
 	 file = download_to_file(url,matches[2]..'|@MaxTeamCh.zip')
	td.sendDocument(get_receiver(msg), 0, 0, 1, nil, file)
end 
		-------------Converter   -------------
 if matches[1]:lower() == 'fa' and matches[2] then
    text = matches[2]:lower()
   if string.len(text) > 100 then 
      return "More than 100 characters are not allowed"
      end
if string.match(text, 'a') then    text = string.gsub(text, 'a', "ش")     end
if string.match(text, 'b') then    text = string.gsub(text, 'b', "ذ")     end
if string.match(text, 'c') then    text = string.gsub(text, 'c', "ز")     end
if string.match(text, 'd') then    text = string.gsub(text, 'd', "ی")     end
if string.match(text, 'e') then    text = string.gsub(text, 'e', "ث")     end
if string.match(text, 'f') then    text = string.gsub(text, 'f', "ب")     end
if string.match(text, 'g') then    text = string.gsub(text, 'g', "ل")     end
if string.match(text, 'h') then    text = string.gsub(text, 'h', "ا")     end
if string.match(text, 'i') then    text = string.gsub(text, 'i', "ه")     end
if string.match(text, 'j') then    text = string.gsub(text, 'j', "ت")     end
if string.match(text, 'k') then    text = string.gsub(text, 'k', "ن")     end
if string.match(text, 'l') then    text = string.gsub(text, 'l', "م")     end
if string.match(text, 'm') then    text = string.gsub(text, 'm', "ئ")     end
if string.match(text, 'n') then    text = string.gsub(text, 'n', "د")     end
if string.match(text, 'o') then    text = string.gsub(text, 'o', "خ")     end
if string.match(text, 'p') then    text = string.gsub(text, 'p', "ح")     end
if string.match(text, 'q') then    text = string.gsub(text, 'q', "ض")     end
if string.match(text, 'r') then    text = string.gsub(text, 'r', "ق")     end
if string.match(text, 's') then    text = string.gsub(text, 's', "س")     end
if string.match(text, 't') then    text = string.gsub(text, 't', "ف")     end
if string.match(text, 'u') then    text = string.gsub(text, 'u', "ع")     end
if string.match(text, 'v') then    text = string.gsub(text, 'v', "ر")     end
if string.match(text, 'w') then    text = string.gsub(text, 'w', "ص")     end
if string.match(text, 'x') then    text = string.gsub(text, 'x', "ط")     end
if string.match(text, 'y') then    text = string.gsub(text, 'y', "غ")     end
if string.match(text, 'z') then    text = string.gsub(text, 'z', "ظ")     end
if string.match(text, ',') then    text = string.gsub(text, ',', "و")     end
if string.match(text, "`") then    text = string.gsub(text, '`', "پ")     end
if string.match(text, "'") then    text = string.gsub(text, "'", "گ")     end
if string.match(text, ';') then    text = string.gsub(text, ';', "ک")     end
if string.match(text, ']') then    text = string.gsub(text, ']', "چ")     end
return text

 elseif matches[1]:lower() == 'en' and matches[2] then
     text = matches[2]:lower()
     if string.len(text) > 100 then 
        return "More than 100 characters are not allowed"
     end
if string.match(text, 'ش') then    text = string.gsub(text, 'ش', "a")     end
if string.match(text, 'ذ') then    text = string.gsub(text, 'ذ', "b")     end
if string.match(text, 'ز') then    text = string.gsub(text, 'ز', "c")     end
if string.match(text, 'ی') then    text = string.gsub(text, 'ی', "d")     end
if string.match(text, 'ث') then    text = string.gsub(text, 'ث', "e")     end
if string.match(text, 'ب') then    text = string.gsub(text, 'ب', "f")     end
if string.match(text, 'ل') then    text = string.gsub(text, 'ل', "g")     end
if string.match(text, 'ا') then    text = string.gsub(text, 'ا', "h")     end
if string.match(text, 'ه') then    text = string.gsub(text, 'ه', "i")     end
if string.match(text, 'ت') then    text = string.gsub(text, 'ت', "j")     end
if string.match(text, 'ن') then    text = string.gsub(text, 'ن', "k")     end
if string.match(text, 'م') then    text = string.gsub(text, 'م', "l")     end
if string.match(text, 'ئ') then    text = string.gsub(text, 'ئ', "m")     end
if string.match(text, "د") then    text = string.gsub(text, 'د', "n")     end
if string.match(text, 'خ') then    text = string.gsub(text, 'خ', "o")     end
if string.match(text, 'ح') then    text = string.gsub(text, 'ح', "p")     end
if string.match(text, 'ض') then    text = string.gsub(text, 'ض', "q")     end
if string.match(text, 'ق') then    text = string.gsub(text, 'ق', "r")     end
if string.match(text, 'س') then    text = string.gsub(text, 'س', "s")     end
if string.match(text, 'ف') then    text = string.gsub(text, 'ف', "t")     end
if string.match(text, 'ع') then    text = string.gsub(text, 'ع', "u")     end
if string.match(text, 'ر') then    text = string.gsub(text, 'ر', "v")     end
if string.match(text, 'ص') then    text = string.gsub(text, 'ص', "w")     end
if string.match(text, 'ط') then    text = string.gsub(text, 'ط', "x")     end
if string.match(text, 'غ') then    text = string.gsub(text, 'غ', "y")     end
if string.match(text, 'ظ') then    text = string.gsub(text, 'ظ', "z")     end
if string.match(text, 'چ') then    text = string.gsub(text, 'چ', "ch")    end
if string.match(text, 'خ') then    text = string.gsub(text, 'خ', "kh")    end
return text
end

      -------------reverse Character text   -------------
  if matches[1]:lower() == 'roll' then
     roll =  string.reverse(matches[2])
     return roll
     end
       -------------Count Character text   -------------
  if matches[1]:lower() == 'count' then
     count =  string.len(matches[2])
     return count
end
end

  return {
    patterns = {
    '^(food)$',
	'^(logo) (.*)$',
	'^(anime)$',
	'^(vid) (.+)$',
    '^(voice) (.+)$',
	'^(time)$',
	'^(tr) (.+) (.+)$',
	'^(keep) (.+) (.+) (.+) (.+)$',
    '^(weather) (.*)$',
	'^(mobile)$',
	'^(love) (.*) (.*)$',
	'^(lua) (.*)$',
	'^[$](.*)$',
	'^(count) (.*)',
    '^(en) (.*)$',
    '^(fa) (.*)$',
    '^(git) (.*)',
    '^(gituser) (.*)/(.*)',
    '^(gitdl) (.*)/(.*)',
    '^(roll) (.*)'
    },
    run = run,
  }
