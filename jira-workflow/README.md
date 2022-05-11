# JIRA API

## Getting Started

1. Ensure that you have configured your own JIRA Cloud tenant.  [Atlassian Admin](https://admin.atlassian.com/)
2. Create a JIRA Project
3. [Generate a JIRA API Key](https://id.atlassian.com/manage-profile/security/api-tokens)
4. Create the file below, which is already .gitignored.  
5. Ensure that it is exported as an ENV variable.

```bash
# Create file using JIRA API KEY from https://id.atlassian.com/manage-profile/security/api-tokens
cat > ../JIRA.SECRET <<EOF
[YOUR_JIRA_API_KEY]
EOF

export AUTH_SECRET="$(cat ../JIRA.SECRET)"

npm i

# RUN CORE APP
node app.js

# RUN TEST
node tests/createJira.test.js

```
