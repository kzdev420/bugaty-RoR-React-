const path = require('path')
const { environment } = require('@rails/webpacker')

const customConfig = {
  resolve: {
    alias: {
      '@modules': path.resolve(__dirname, '..', '..', 'app/javascript/packs/modules'),
    }
  }
}


environment.config.merge(customConfig)

console.log(environment.toWebpackConfig())
module.exports = environment
