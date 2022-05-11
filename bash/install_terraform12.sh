#!/usr/bin/env bash

# Copyright 2021 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#            http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

### AS OF August 6, 2019, gwcx recommends Terraform v0.11.14.  v0.12.x has breaking changes.  Use at your own risk.

function install_terraform12() {
    sudo apt-get install unzip

    VERSION="0.12.30"

    wget https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip

    unzip terraform_$VERSION_linux_amd64.zip

    sudo mv terraform /usr/local/bin/

    terraform --version

    # remove .zip file
    rm -rf terraform_$VERSION_linux_amd64.zip
}

install_terraform12
