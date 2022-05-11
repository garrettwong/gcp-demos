const request = require('request');
const axios = require('axios')

class JiraService {
    constructor() {}

    /**
     * @param {string} jiraId - The JIRA Project combined with the JIRA Number (CLOUD-12345)
     */
    async getJira(jiraId, cb) {
        let url = `https://gwongclouddev.atlassian.net/rest/api/2/issue/${jiraId}`;
        let result = await axios.get(url, {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Basic =',
            }
        });
        return result;
    }

    /**
     * @param cb {function(error, response)} - callback fn
     */
    getJiraByJql(jql, cb) {
        var options = {
            'method': 'GET',
            'url': `https://gwongclouddev.atlassian.net/rest/api/2/search?jql=${jql}`,
            'headers': {
                'Authorization': 'Basic =',
            }
        };

        request(options, cb);
    }

    /**
     */
    async createJira(data) {
        let url = 'https://gwongclouddev.atlassian.net/rest/api/2/issue';
        let options = {
            headers: {
                'Authorization': 'Basic =',
                'content-type': 'application/json'
            }
        };

        return await axios.post(url, data, options)
    }


    /**
     * @param  {} jiraId - The JIRA Project combined with the JIRA Number (CLOUD-12345)
     * @param  {} cb - The call back function
     */
    async approveJira(jiraId, cb) {
        let url = `https://gwongclouddev.atlassian.net/rest/api/2/issue/${jiraId}/comment`;
        let options = {
            headers: {
                'Authorization': 'Basic =',
                'content-type': 'application/json'
            }
        };

        let data = {
            body: 'Approved'
        };

        return await axios.post(url, data, options)
    }

    /**
     * @param  {} jiraId - The JIRA Project combined with the JIRA Number (CLOUD-12345)
     * @param  {} cb - The call back function
     */
    async reassignJira(jiraId, assignee, cb) {
        let url = `https://gwongcloudev.atlassian.net/rest/api/2/issue/${jiraId}`;
        let options = {
            headers: {
                'Authorization': 'Basic ',
                'content-type': 'application/json'
            }
        };

        let data = {
            'fields': {
                'assignee': {
                    'name': assignee
                }
            }
        };

        return await axios.put(url, data, options)
    }

    /**
     * @param  {} jiraId
     * @param  {} cb
     */
    async assignJiraToGarrett(jiraId, cb) {
        return await this.reassignJira(jiraId, 'garrettwong', cb);
    }
    /**
     * @param  {} jiraId
     * @param  {} cb
     */
    async assignJiraToGarrettsAutomation(jiraId, cb) {
        return await this.reassignJira(jiraId, 'garrettwong', cb);
    }
}

module.exports = new JiraService();