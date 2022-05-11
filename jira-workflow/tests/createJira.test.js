const JiraService = require('../lib/jira-service.js');
const JIRATemplates = require('../lib/jira-templates.js');

(async () => {
    try {
        let jiraService = new JiraService(process.env.AUTH_SECRET)
        let a = await jiraService.createJira(JIRATemplates.default)
        console.log(a)

        console.log('testing')

        await jiraService.approveJira(a.data.key);

        console.log('comment that says: approved')
    } catch (e) {
        // Deal with the fact the chain failed

        console.log('fail', e)
    }
})();