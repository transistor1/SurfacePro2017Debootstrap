#!/bin/bash


DIR=$(dirname "$0")
ROOT=/mnt/img0
TMP=${ROOT}/tmp

cat > ${TMP}/surface.sh << EOF
git clone --depth 1 https://github.com/jakeday/linux-surface.git /tmp/linux-surface
cd /tmp/linux-surface
sh setup.sh

EOF

chmod +x ${TMP}/surface.sh

chroot ${ROOT} bash -c "cd /tmp && sh ./surface.sh"
rm -rf ${TMP}/linux-surface
rm -rf ${TMP}/surface.sh

