evalFile = require 'cush/utils/evalFile'
path = require 'path'
fs = require 'saxon'

nebu = require '@cush/nebu'
nebu.acorn = require 'acorn'

module.exports = ->
  shared =
    sourceMaps: true
    plugins: @get 'nebu.plugins', []

  doneHook = @hook 'nebu'

  @hook 'package', (pack) ->
    if config = await loadConfig pack.path
      {plugins} = config
      Object.assign config, shared
      if Array.isArray plugins
        config.plugins = plugins.concat shared.plugins
      pack.nebu = config
      return

  @transform '.js', (asset, pack) ->
    config = pack.nebu or shared
    return if !config.plugins.length

    config = Object.create config
    config.state = {}
    config.filename = asset.path

    result = nebu.process asset.content, config
    doneHook.emit asset, config.state
    return result

# TODO: watch `nebu.config.js` for changes
loadConfig = (root) ->
  configPath = path.join root, 'nebu.config.js'
  if await fs.isFile configPath
    config = evalFile configPath
    if Array.isArray config
      plugins: config
    else config
  else null
