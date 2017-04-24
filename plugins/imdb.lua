do

  local function run(msg, matches)
    local omdbapi = 'http://www.omdbapi.com/?plot=full&r=json'
    local movietitle = matches[1]
    local chat_id = msg.chat_id_

    if matches[1]:match(' %d%d%d%d$') then
      local movieyear = matches[1]:match('%d%d%d%d$')
      movietitle = matches[1]:match('^.+ ')
      omdbapi = omdbapi .. '&y=' .. movieyear
    end

    local success, code = http.request(omdbapi .. '&t=' .. URL.escape(movietitle))

    if not success then
      return  _('Connection error')
    end

    local jomdb = json.decode(success)

    if not jomdb then
      return  '*' .. json.decode(code) .. '*'
    elseif jomdb.Response == 'False' then
      return '*' .. jomdb.Error .. '*'
    end

    local omdb = _('*%s*\n\n'
                      .. '*Year* [:](%s) %s\n'
                      .. '*Rated*: %s\n'
                      .. '*Runtime*: %s\n'
                      .. '*Genre*: %s\n'
                      .. '*Director*: %s\n'
                      .. '*Writer*: %s\n'
                      .. '*Actors*: %s\n'
                      .. '*Country*: %s\n'
                      .. '*Awards*: %s\n'
                      .. '*Plot*: %s\n\n'
                      .. '[IMDB](http://imdb.com/title/%s)\n'
                      .. '*Metascore*: %s\n'
                      .. '*Rating*: %s\n'
                      .. '*Votes*: %s\n'):format(jomdb.Title,
                                                      jomdb.Poster,
                                                      jomdb.Year,
                                                      jomdb.Rated,
                                                      jomdb.Runtime,
                                                      jomdb.Genre,
                                                      jomdb.Director,
                                                      jomdb.Writer,
                                                      jomdb.Actors,
                                                      jomdb.Country,
                                                      jomdb.Awards,
                                                      jomdb.Plot,
                                                      jomdb.imdbID,
                                                      jomdb.Metascore,
                                                      jomdb.imdbRating,
                                                      jomdb.imdbVotes
    )
    api.sendMessage(msg.to.id, omdb, 'md', nil, nil, true)
  end

--------------------------------------------------------------------------------

  return {
    description = 'The Open Movie Database plugin for Telegram.',
    usage = {
        '`!imdb [movie]`',
        '`!omdb [movie]`',
        'Returns IMDb entry for `[movie]`',
        '*Example*' .. ': `!imdb the matrix`',
        '',
        '`!imdb [movie] [year]`',
        '`!omdb [movie] [year]`',
        'Returns IMDb entry for `[movie]` that was released in `[year]`',
        '*Example*' .. ': `!imdb the matrix 2003`',
      
    },
    patterns = {
      'imdb (.*)',
    },
    run = run
  }

end