const { GoogleAuth } = require('google-auth-library')
const fetch = require('node-fetch')

class IAMRole {
  constructor(name, title, permissions) {
    this.name = name
    this.title = title
    this.permissions = permissions
  }

  print() {
    console.log(this.title + '-' + this.name)
    console.log(this.permissions)
  }
}

function getPredefinedRolesFromFilesystem(pathToRoles) {
  const yaml = require('js-yaml')
  const fs = require('fs')

  let files = fs.readdirSync(pathToRoles)

  let predefinedIamRoles = []
  for (let idx in files) {
    let fileName = files[idx]
    let doc = yaml.load(fs.readFileSync(`${pathToRoles}/${fileName}`, 'utf8'))
    let ir = new IAMRole(doc.name, doc.title, doc.includedPermissions)
    predefinedIamRoles.push(ir)
  }
  return predefinedIamRoles
}

async function main() {
  // Get document, or throw exception on error
  try {
    let predefinedIamRoles = getPredefinedRolesFromFilesystem(
      '../iam-role-fetch/roles',
    )

    for (let idx in predefinedIamRoles) {
      let predefinedIamRole = predefinedIamRoles[idx]
      // predefinedIamRole.print()
    }
    predefinedIamRoles.sort(function (a, b) {
      if (!a.permissions || !b.permissions) {
        return b
      }
      
      if (a.permissions.length > b.permissions.length) return b
      else return a
    })
    console.log(predefinedIamRoles[0].permissions.length)
    console.log(
      predefinedIamRoles[predefinedIamRoles.length - 1].permissions.length,
    )

    const auth = new GoogleAuth({
      scopes: 'https://www.googleapis.com/auth/cloud-platform',
    })
    const client = await auth.getClient()
    const projectId = await auth.getProjectId()
    let url = `https://dns.googleapis.com/dns/v1/projects/${projectId}`
    let res = await client.request({ url })
    console.log(res.data)

    url = `https://recommender.googleapis.com/v1/projects/gwc-sandbox/locations/global/insightTypes/google.iam.policy.Insight/insights`
    const headers = await client.getRequestHeaders()
    headers['X-Goog-User-Project'] = projectId

    // Attach those headers to another request, and use it to call a Google API
    res = await fetch(url, { headers })
    data = await res.json()
    let permissions = data.insights[0].content.exercisedPermissions.map(
      (d) => d.permission,
    )
    permissions = permissions.concat(
      data.insights[0].content.inferredPermissions.map((d) => d.permission),
    )
    console.log(permissions.sort())

    // We now need to compare the permission set and find the least set of matching predefined roles?
    let altPermissionSet = []
    let diffScore = 0
    for (let i = 0; i < predefinedIamRoles.length; i++) {
      for (let j = 0; j < permissions.length; j++) {
        if (
          !predefinedIamRoles[i].permissions ||
          predefinedIamRoles[i].permissions.length === undefined
        )
          continue

        let match = false
        for (let k = 0; k < predefinedIamRoles[i].permissions.length; k++) {
          if (permissions[j] === predefinedIamRoles[i].permissions[k]) {
            // naively we will use the first matching permission set, select FIRST
            permissions.splice(j, 1)
            match = true
          }
        }

        if (match) {
          altPermissionSet.push(predefinedIamRoles[i])
        }
      }
    }

    console.log('discovered set')
    console.log(altPermissionSet.length)

    const fs = require('fs')

    fs.writeFile('test.json', JSON.stringify(altPermissionSet), (err) => {
      if (err) {
        console.error(err)
        return
      }
      //file written successfully
    })

    // console.log('Headers:')
    // console.log(headers)
    // console.log(data)
    // console.log(data.insights[0])
    // console.log(data.insights[0].targetResources)
    // console.log(data.insights[0].content.role)
    // console.log(data.insights[0].content.member)
    // console.log(data.insights[0].content.exercisedPermissions)
    // console.log(data.insights[0].content.inferredPermissions)
  } catch (e) {
    console.log(e)
  }
}

;(async () => {
  await main()
})()

// References: https://cloud.google.com/policy-intelligence/docs/policy-insights#get-a-single-policy-insight
