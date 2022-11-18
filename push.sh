#!/bin/bash

set -e

echo "Install dependencies"
sudo gem install package_cloud

RPM_DSTS="sles/11.4 sles/12.0 sles/12.1 sles/12.2
 opensuse/13.1 opensuse/13.2 opensuse/42.1 opensuse/42.2
 fedora/20 fedora/21 fedora/22 fedora/23 fedora/24 fedora/25 fedora/26 fedora/27 fedora/28
 el/5 el/6 el/7 el/8"

DEB_DSTS="debian/wheezy debian/jessie debian/stretch debian/buster
 ubuntu/trusty ubuntu/utopic ubuntu/vivid ubuntu/wily ubuntu/xenial ubuntu/yakkety ubuntu/zesty ubuntu/artful ubuntu/bionic ubuntu/disco ubuntu/focal ubuntu/jammy
 raspbian/wheezy raspbian/jessie raspbian/stretch raspbian/buster"


echo "PACKAGECLOUD_REPO=${PACKAGECLOUD_REPO}"
# echo "PACKAGECLOUD_DISTRIB=${PACKAGECLOUD_DISTRIB}"
echo "DEB_PACKAGE__NAME=${DEB_PACKAGE_NAME}"
echo "RPM_PACKAGE_NAME=${RPM_PACKAGE_NAME}"

UPLOAD_PATH="${PACKAGECLOUD_USERNAME}/${PACKAGECLOUD_REPO}"


if [ -n "${DEB_PACKAGE_NAME}" ]; then
    for DST in ${DEB_DSTS[@]}; do
				echo "Uploading ${DEB_PACKAGE_NAME} to $DST"
				package_cloud push ${UPLOAD_PATH}/${DST} ${DEB_PACKAGE_NAME} --skip-errors
    done
fi

if [ -n "${RPM_PACKAGE_NAME}" ]; then
    for DST in ${RPM_DSTS[@]}; do
				echo "Uploading ${RPM_PACKAGE_NAME} to $DST"
				package_cloud push ${UPLOAD_PATH}/${DST} ${RPM_PACKAGE_NAME} --skip-errors
    done
fi
# if [ -n "${PACKAGECLOUD_DISTRIB}" ]; then
#     UPLOAD_PATH="${UPLOAD_PATH}/${PACKAGECLOUD_DISTRIB}"
# fi

# echo "Deploying package: ${PACKAGE_NAME}"
# echo "To repository: ${UPLOAD_PATH}"
# package_cloud push ${UPLOAD_PATH} ${PACKAGE_NAME}
