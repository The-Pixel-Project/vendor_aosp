#!/bin/bash
#
# Copyright (C) 2024 The Pixel Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# $1=TARGET_DEVICE, $2=PRODUCT_OUT, $3=FILE_NAME
existingOTAjson=./vendor/official_devices/OTA/devices/$1.json
output=$2/$1.json
version=$4

# cleanup old file
if [ -f $output ]; then
        rm $output
fi

echo "Generating JSON file data for OTA support..."

if [ -f $existingOTAjson ]; then
        # get data from already existing device json
        maintainer=`grep -n "\"maintainer\"" $existingOTAjson | cut -d ":" -f 3 | sed 's/"//g' | sed 's/,//g' | xargs`
        oem=`grep -n "\"oem\"" $existingOTAjson | cut -d ":" -f 3 | sed 's/"//g' | sed 's/,//g' | xargs`
        device=`grep -n "\"device\"" $existingOTAjson | cut -d ":" -f 3 | sed 's/"//g' | sed 's/,//g' | xargs`
        filename=$3
        version=`echo $version`
        buildprop=$2/system/build.prop
        linenr=`grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
        timestamp=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
        md5=`md5sum "$2/$3" | cut -d' ' -f1`
        sha256=`sha256sum "$2/$3" | cut -d' ' -f1`
        size=`stat -c "%s" "$2/$3"`
        forum=`grep -n "\"forum\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
        if [ ! -z "$forum" ]; then
                forum="https:"$forum
        fi
        telegram=`grep -n "\"telegram\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
        if [ ! -z "$telegram" ]; then
                telegram="https:"$telegram
        fi
        

        echo '{
        "response": [
                {
                        "maintainer": "'$maintainer'",
                        "oem": "'$oem'",
                        "device": "'$device'",
                        "version": "'$version'",
                        "filename": "'$filename'",
                        "download": "https://sourceforge.net/projects/pixel-project/files/'$1'/'$3'/download",
                        "timestamp": '$timestamp',
                        "md5": "'$md5'",
                        "sha256": "'$sha256'",
                        "size": '$size',
                        "forum": "'$forum'",
                        "telegram": "'$telegram'"
                }
        ]
}' >> $output
else
        filename=$3
        version=`echo $version`
        buildprop=$2/system/build.prop
        linenr=`grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
        timestamp=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
        md5=`md5sum "$2/$3" | cut -d' ' -f1`
        sha256=`sha256sum "$2/$3" | cut -d' ' -f1`
        size=`stat -c "%s" "$2/$3"`

        echo '{
        "response": [
                {
                        "maintainer": "''",
                        "oem": "''",
                        "device": "''",
                        "version": "'$version'",
                        "filename": "'$filename'",
                        "download": "https://sourceforge.net/projects/pixel-project/files/'$1'/'$3'/download",
                        "timestamp": '$timestamp',
                        "md5": "'$md5'",
                        "sha256": "'$sha256'",
                        "size": '$size',
                        "forum": "''",
                        "telegram": "''"
                }
        ]
}' >> $output

        echo 'There is no official support for this device yet'
        echo 'Apply from https://github.com/The-Pixel-Project/official_devices'
fi

echo ""
