const JIRATemplates = {
  default: {
      
    fields: {
      project: {
        key: "GOOG"
      },
      issuetype: {
        self: 'https://gwongclouddev.atlassian.net/rest/api/2/issuetype/10001',
        id: '10001',
        description: 'Functionality or a feature expressed as a user goal.',
        iconUrl: 'https://gwongclouddev.atlassian.net/rest/api/2/universal_avatar/view/type/issuetype/avatar/10315?size=medium',
        name: 'Story',
        subtask: false,
        avatarId: 10315,
        hierarchyLevel: 0
      },
      summary: 'Default Summary',
      customfield_10006: {
        self: 'https://gwongclouddev.atlassian.net/rest/api/2/customFieldOption/10020',
        value: 'Stop, Drop and Fix!',
        id: '10020'
      }
    },
    
  }
};

module.exports = JIRATemplates;