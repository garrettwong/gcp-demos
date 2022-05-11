#!/usr/bin/env bash

function install_terraform12() {
    VERSION="0.12.30"

    wget https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_darwin_amd64.zip

    unzip terraform_${VERSION}_darwin_amd64.zip

    sudo mv terraform /usr/local/bin/terraform12

    terraform --version

    # remove .zip file
    rm -rf terraform_$VERSION_darwin_amd64.zip
}

install_terraform12