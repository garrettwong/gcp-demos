const fs = require('fs')
const request = require('request')
const JiraService = require('./lib/jira-service')
const JIRATemplates = require('./lib/jira-templates')
const util = require('util')

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

  let jiraService = new JiraService(process.env.AUTH_SECRET)

  // jiraService.getJiras(function (error, response, body) {
  //   if (error) throw new Error(error)

  //   logger.debug(JSON.stringify(body))
  // })

  // let res = jiraService.getJira('GOOG-1')
  // res.then(function(response) {
  //   logger.debug(response)
  //   console.log(util.inspect(response.data))
  // })

  let data = JIRATemplates.default
  jiraService.createJira(data)
}

if (require.main === module) {
  main()
}
