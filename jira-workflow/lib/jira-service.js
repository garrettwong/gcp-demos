const request = require('request')
const axios = require('axios')

class JiraService {
  constructor(authorization) {
    this._authorization = authorization
  }

  /**
   * @param {string} jiraId - The JIRA Project combined with the JIRA Number (CLOUD-12345)
   */
  async getJiras(cb) {
    let options = {
      method: 'GET',
      url: 'https://gwongclouddev.atlassian.net/rest/api/2/search',
      headers: {
        'cache-control': 'no-cache',
        authorization: this._authorization,
      },
    }

    request(options, cb)
  }

  /**
   * @param {string} jiraId - The JIRA Project combined with the JIRA Number (CLOUD-12345)
   */
  async getJira(jiraId) {
    let url = `https://gwongclouddev.atlassian.net/rest/api/2/issue/${jiraId}`
    let result = await axios.get(url, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: this._authorization,
      },
    })
    return result
  }

  /**
   * @param cb {function(error, response)} - callback fn
   */
  getJiraByJql(jql, cb) {
    var options = {
      method: 'GET',
      url: `https://gwongclouddev.atlassian.net/rest/api/2/search?jql=${jql}`,
      headers: {
        Authorization: this._authorization,
      },
    }

    request(options, cb)
  }


  /**
   * @param  {} data - The JIRA ticket data to create
   */
  async createJira(data) {
    let url = 'https://gwongclouddev.atlassian.net/rest/api/2/issue'
    let options = {
      headers: {
        Authorization: this._authorization,
        'content-type': 'application/json',
      },
    }

    return await axios.post(url, data, options)
  }

  /**
   * @param  {} jiraId - The JIRA Project combined with the JIRA Number (CLOUD-12345)
   * @param  {} cb - The call back function
   */
  async approveJira(jiraId, cb) {
    let url = `https://gwongclouddev.atlassian.net/rest/api/2/issue/${jiraId}/comment`
    let options = {
      headers: {
        Authorization: this._authorization,
        'content-type': 'application/json',
      },
    }

    let data = {
      body: 'Approved',
    }

    return await axios.post(url, data, options)
  }

  /**
   * @param  {} jiraId - The JIRA Project combined with the JIRA Number (CLOUD-12345)
   * @param  {} cb - The call back function
   */
  async reassignJira(jiraId, assignee, cb) {
    let url = `https://gwongcloudev.atlassian.net/rest/api/2/issue/${jiraId}`
    let options = {
      headers: {
        Authorization: this._authorization,
        'content-type': 'application/json',
      },
    }

    let data = {
      fields: {
        assignee: {
          name: assignee,
        },
      },
    }

    return await axios.put(url, data, options)
  }

  /**
   * @param  {} jiraId
   * @param  {} cb
   */
  async assignJiraToGarrett(jiraId, cb) {
    return await this.reassignJira(jiraId, 'garrettwong', cb)
  }
  /**
   * @param  {} jiraId
   * @param  {} cb
   */
  async assignJiraToGarrettsAutomation(jiraId, cb) {
    return await this.reassignJira(jiraId, 'garrettwong', cb)
  }
}

module.exports = JiraService
