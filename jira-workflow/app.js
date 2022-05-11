const fs = require('fs')
const request = require('request')

function configureLogger() {
  const log4js = require('log4js')
  log4js.configure({
    appenders: { gappend: { type: 'file', filename: 'execution.log' } },
    categories: { default: { appenders: ['gappend'], level: 'error' } },
  })
  const logger = log4js.getLogger()

  logger.category = 'gcp-demos/jira-workflow'
  logger.level = 'debug'

  return logger
}

function main() {
  let logger = configureLogger()

  logger.debug('Beginning Execution')

  let options = {
    method: 'GET',
    url: 'https://gwongclouddev.atlassian.net/rest/api/2/search',
    headers: {
      'cache-control': 'no-cache',
      authorization: process.env.AUTH_SECRET
    },
  }

  request(options, function (error, response, body) {
    if (error) throw new Error(error)

    console.log("Body", body)
    logger.debug(JSON.stringify(body))
  })
}

if (require.main === module) {
  main()
}
