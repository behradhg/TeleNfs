
function inpm(cb_extra,result)
-- td.sendText(tonumber(msg.to.id), 0, 1, 0, nil, 'hello', 0, 'html', ok_cb, cmd)
return msg
end
local function run(msg,matches)
print(msg.to.type)
if msg.to.type ~= 'user' then 
return 
end
if matches[1] == 'start' then
return 'welcome to NFS~bot\ni am best anti spamer bot🖕🏾\nList of bot commands :\nhelp : for see this passeg\ngplist : for see public bots group\nsupport : for see support users\nshare : for see bot number\nboobs : Get a boobs NSFW image\njoin : for join support chat\nid : for see your id\nversion : for see version'
end
end
return {
    description = 'manege bot pv.',
    usage = {
        '*help doesnt exited*',
    },
  patterns = {
	"(help)$",
	"(start)",
	"(pmhelp)$",
	"(superhelp)$",
    "(chats)$",
    "(chatlist)$",
    "(join) (%d+)$",
  }, 
  -- pre_process = inpm,
  run = run
}

-- edited by behrad
