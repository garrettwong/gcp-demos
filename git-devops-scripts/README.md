# GIT Secrets

## Overview

* Prevent Service Account JSON Key File accidental commit/upload

## Getting Started

Installation

```bash
./install.osx.git-secrets.sh
```

### Adding Git Secrets

```bash
git secrets --add 'private_key"'
```

### Removing Git Secrets

```bash
vi ../.git/config # remove lines under [secrets]
```

### Bypassing Git Secrets on Commit

Bypassing the warning on a `git commit`

```bash
git commit -m "Message" --no-verify
```

## Reference

For Mac OSX:

* [Reference](https://github.com/awslabs/git-secrets#installing-git-secrets)
* [Reference](https://cloud.google.com/blog/products/gcp/help-keep-your-google-cloud-service-account-keys-safe)
