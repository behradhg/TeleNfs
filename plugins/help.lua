
  -- Returns true if is not empty
  local function has_usage_data(dict)
    if (dict.usage == nil or dict.usage == '') then
      return false
    end
    return true
  end


  local function telegram_help(msg)
    local i = 0
	    local keyboard = {}

    local text = '*Plugins*\n\n'
    local xline = {}

   local keyboard = {}
      local xline = {}
	i = 0
	for name,bk in pairs(HELP) do
	i = i + 1

        line = {text = tostring('📍'..name), callback_data = 'help:'..name}
        table.insert(xline, line)
		
		if #xline == 3 then
		table.insert(keyboard, xline)
		xline = {}
		end
      end
     if next(xline) then --if the numer of buttons is odd, then add the last button alone
            table.insert(keyboard, xline)
        end
    text = '\n' .. 'There are *' .. i .. '* plugins help available.\n'
           .. '*-* `!help [plugin name]` for more info.\n'
           .. '*-* `!help [plugin number]` for more info.\n'
           .. '*-* `!help all` to show all info.'
  send_inline(msg.to.id, text, keyboard) 
  end

--  -- !help all command
--  local function help_all(requester)
--    local ret = ''
--    for name in pairsByKeys(plugins) do
--      if plugins[name].hidden then
--        name = nil
--      else 
--        ret = ret .. plugin_help(name, nil, requester)
--      end
--    end
--    return ret
--  end

  --------------------------------------------------------------------------------
local gp_mod = {
en = [[`help for plugin gpmod :`
sudo users :
`/sudo or visudo :`
promote user as sudo user
`/desudo :`
demote user as sudo user
`/sudolist :`
list of sudo users
`/admin or adminprom` :
for set user as bot admin
`/admindem or deamin` :
for demote user as admin

bot admin commands :
`/setleader or gl :`
for promote user as leader
`/setowner or gov`
for promote user as owner
`/remowner or degov`
remove user os owners
`/gadd or addgroup`
for add group
`/grem or remgroup`
for remove group
`/setall`
set all group admins os mods
`/adminlist`
see list of admins
`/superban or gban or hammer`
for banall user
`/superunban or gunban or unhammer`
for unbanall user

owners command :
`/setprivate :`
set group private
`/setpublic`
set group public
`/cmds [mod owner member]`
set alwd user
`/revoke `
for revoke group token
`/token`
for create token
`/warnmod [kick , ban , disable]`
set warnmod
`/warnmax [10<.>0]`
set max warning
`/filters or filterlist`
for show filter commands
`/filter [word] [action]`
filter word white action
`/unfilter [word]`
unfilter word
`/warn `
warning user
`/unwarn`
unwarn user
`/warnlist`
see warn users list
`/setlink or link set`
if twe pramter then set link
/link revoke
revoke group link
`/group [bots  , kicked , admins ,members]`
show lists
`/setname [name]`
setgroup name

mods commands :
`/sticker [del , warn , ok , kick , ban]
/links [del , warn , ok , kick , ban]
/arabic [del , warn , ok , kick , ban]
/photo [del , warn , ok , kick , ban]
/gif [del , warn , ok , kick , ban]
/video [del , warn , ok , kick , ban]
/gif [del , warn , ok , kick , ban]
/fwd [del , warn , ok , kick , ban]`
set lock to models
`/gp lock or lock [all , bot , member]`
lock all must be mute all
lock bots anony cant add bots
lock member : kick join users or addmember 
`/gp unlock or unlock [all , bot , member]`
unlock all must be unmute all
unlock bots anony can add bots
unlock member : then do not kick join users or addmember 
`/setwelcome`
for set welcome to custom command
`/resetwelcome`
restor welcome settings
`/setabout `
set group about
`/about `
get group about
`/setrules`
set group rules
`/rules `
get group rules
`/superbanlist or gbanlist or hammerlist`
show list of banall user
`/promote or mod`
add mod user
`/demote or demod`
remove mod user
`/clear [mods , filters ,owners , bots , admins ,msg ,member]`
clean lists
`/backup`
get groupp config
`/group settings or settings`
for show group settings
`/kick `
kick user
`/ban `
for ban users
`/unban`
for unban users
`/banlist`
for see banlist
`/gllist`
for see group leader
`/modlist`
show list of mods
`/link or getlink or link get`
for get group link
`/grouplist or groups `
for see bot public groups
`/ownerlist`
see ownerlist

]]
}
  local function run(msg, matches)
    local uid = msg.from.peer_id
    local gid = msg.to.peer_id
if matches[1] == 'help' then
      return telegram_help(msg)
   end
   if matches[1] == 'sethelp' and is_sudo(uid) then
   HELP = write_help()
   return 'help has benn writed'
   end
   
   if matches[1] == 'gpmod' then
   return gp_mod.en
   end
  end
  local function get_helped_string(key)
	
end
  local function call_back(msg,blocks)
  if HELP[blocks[2]] then
    api.answerCallbackQuery(msg.id, 'help for '..blocks[2], false)
  local text = 'Help for '..blocks[2]
  local help = HELP[blocks[2]]
  text = text..'\n*Description* *-* `'..help.description..'`'
  text = text..'\n*help text : *\n'
  for k,v in pairs(help.usage) do
  text = text..' *-* '.._(v)..'\n'
  end
      local keyboard = {}
      local xline = {}
	i = 0
	for name,bk in pairs(HELP) do
	i = i + 1
	if name == blocks[2] then
	        line = {text = tostring('📊'..name), callback_data = 'help:'..name}
	else
        line = {text = tostring('📍'..name), callback_data = 'help:'..name}
	end
        table.insert(xline, line)
		
		if #xline == 3 then
		table.insert(keyboard, xline)
		xline = {}
		end
      end
     if next(xline) then --if the numer of buttons is odd, then add the last button alone
            table.insert(keyboard, xline)
        end
   editMessageText(msg.message.chat.id, msg.message.message_id, text,true,keyboard)
  end
  end 

  return {
    description = 'Help plugin. Get info from other plugins.',
    usage = {
      '`!help`',
      'Show list of plugins.',
      '',
      '`!help all`',
      'Show all commands for every plugin.',
      '',
      '`!help [plugin_name]`',
      'Commands for that plugin.',
      '',
      '`!help [number]`',
      'Commands for that plugin. Type !help to get the plugin number.'
    },
    patterns = { 
      '^(help)$',
	  '^(sethelp)',
	  '^(gpmod)'
    },
	triggers  = {
	'^(help):(.*)'
	},
    run = run,
    call = call_back
  }

