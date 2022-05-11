# JIRA API

## Getting Started

```bash
# Create file using JIRA API KEY from https://id.atlassian.com/manage-profile/security/api-tokens
cat > ../JIRA.SECRET <<EOF
[YOUR_JIRA_API_KEY]
EOF

export AUTH_SECRET="$(cat ../JIRA.SECRET)"

node app.js
```
