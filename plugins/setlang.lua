do
  local function run(msg, matches)
  if msg.to.type == 'user' then
  return 'این ابزار فقط برای گروه ها میباشد'
  end
  if not is_owner(msg, msg.to.id, msg.from.id) then
  return _('*User %s plugin is not privileged for you*'):format(get_uname(msg.from.id))
  end
    if matches[2] then
      if matches[2]:match('%a%a') then
        local lang = matches[2]:lower()
	  if not config.available_languages[lang] then
	  return _('*Language not found for see Languages list send* /listlang')
    end
	locale.language = lang
        redis:set('lang:'..msg.to.id, lang)
        local text = _('Bot language is set to *%s*'):format(config.available_languages[lang])
        reply_msg(msg.id, text, ok_cb, true)
      else
		reply_msg(msg.id, _('Language must be in form of two letter *ISO 639-1* language code.'), ok_cb, true)
      end
    elseif matches[1] == _('listlang') or matches[1] == _('setlang') then
      local l = {}
      local lt = config.available_languages
	  i = 0
      for k,v in pairs(lt) do
	  i = i + 1
        if redis:get('lang:'..msg.to.id) == k then
          l[i] = '• `' .. v .. '`  ✔️'
        else
          l[i] = '• `' .. v .. '`'
        end
      end
      local title = _("*List of available language*:\n")
      local langs = table.concat(l, '\n')
	  reply_msg(msg.id, title .. langs, ok_cb, true)

    end
  end

  return {
    description = 'set bot languages',
    usage = {
    'listlang',
	'show list of languages.',
	'',
    'setlang (.text)',
	'setgroup lang to text.',
	'',
    },
    patterns = {
     '(listlang)$',
     '(لیست زبان)',
      '(setlang)$',
      '(setlang) (.*)$',
    },
    run = run,
  }

end