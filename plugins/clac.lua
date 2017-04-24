do

  local function run(msg, matches)
    local result = http.request('http://api.mathjs.org/v1/?expr=' .. URL.escape(matches[1]))

    if not result then
      result = 'Unexpected error\nIs api.mathjs.org up?'
    end
	 reply_msg(msg.id, result, ok_cb, true)

  end

--------------------------------------------------------------------------------

  return {
    description = 'Returns solutions to mathematical expressions and conversions between common units.'
                  .. 'Results provided by mathjs.org.',
    usage = {
        'See: https://t.me/tdclibotmanual/24'
    },
    patterns = {
      'calc (.*)$',
      'calculator (.*)'
    },
    run = run
  }

end