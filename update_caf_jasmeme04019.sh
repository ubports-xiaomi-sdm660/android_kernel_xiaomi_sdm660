#!/bin/bash

echo "Merging Kernel CAF Tag"

git fetch https://source.codeaurora.org/quic/la/kernel/msm-4.19 LA.UM.9.2.1.r1-08700-sdm660.0

git merge FETCH_HEAD

echo "Moving to Subtrees"

echo "Merging qcacld-3.0"

git remote add qcacld-3.0 https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/qcacld-3.0

git fetch qcacld-3.0 LA.UM.9.2.1.r1-08700-sdm660.0

git merge -X subtree=drivers/staging/qcacld-3.0 FETCH_HEAD

echo "Merging fw-api"

git remote add fw-api https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/fw-api

git fetch fw-api LA.UM.9.2.1.r1-08700-sdm660.0

git merge -X subtree=drivers/staging/fw-api FETCH_HEAD


echo "Merging qca-wifi-host-cmn"

git remote add qca-wifi-host-cmn https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn

git fetch qca-wifi-host-cmn LA.UM.9.2.1.r1-08700-sdm660.0

git merge -X subtree=drivers/staging/qca-wifi-host-cmn FETCH_HEAD

echo "Merging Techpack Audio"

git remote add techpacka https://source.codeaurora.org/quic/la/platform/vendor/opensource/audio-kernel/

git fetch techpacka LA.UM.9.2.1.r1-08700-sdm660.0

git merge -X subtree=techpack/audio FETCH_HEAD
