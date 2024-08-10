#!/bin/bash
CL_RED="\033[31m"
CL_CYN="\033[1;36m"
CL_PRP="\033[35m"
CL_NC="\033[0m"
if [ "$1" ]; then
    echo "Generating .json"
    file_path=$1
    file_name=$(basename "$file_path")
    DEVICE=$(echo $TARGET_PRODUCT | sed 's/aosp_//g')
    if [ -f $file_path ]; then
        # only generate for official builds. unless forced with 'export FORCE_JSON=1'
        if [[ $file_name == *"Official"* ]] || [[ $FORCE_JSON == 1 ]]; then
            if [[ $FORCE_JSON == 1 ]]; then
                echo -e "${CL_CYN}Forced generation of json${CL_NC}"
            fi
            file_size=$(stat -c%s $file_path)
            md5=$(md5sum $file_path | awk '{ print $1 }');
            datetime=$(grep ro\.build\.date\.utc ./out/target/product/$DEVICE/system/build.prop | cut -d= -f2);
            id=$(cat "$file_path.sha256sum" | cut -d' ' -f1);
            build_type=$(grep org\.pixelproject\.buildtype ./out/target/product/$DEVICE/system/build.prop | cut -d= -f2);
            base_version=$(grep org\.pixelproject\.base\.version ./out/target/product/$DEVICE/system/build.prop | cut -d= -f2);
            link="https://sourceforge.net/projects/pixel-project/files/${DEVICE}/${file_name}/download"
            echo "{" > $file_path.json
            echo "  \"response\": [" >> $file_path.json
            echo "    {" >> $file_path.json
            echo "      \"timestamp\": ${datetime}," >> $file_path.json
            echo "      \"filename\": \"${file_name}\"," >> $file_path.json
            echo "      \"md5\": \"${md5}\"," >> $file_path.json
            echo "      \"size\": ${file_size}," >> $file_path.json
            echo "      \"download\": \"${link}\"," >> $file_path.json
            echo "      \"version\": \"${base_version}\"" >> $file_path.json
            echo "    }" >> $file_path.json
            echo "  ]" >> $file_path.json
            echo "}" >> $file_path.json
            mv "${file_path}.json" "./${DEVICE}.json"
            echo -e "${CL_CYN}Done generating ${CL_PRP}${DEVICE}.json${CL_NC}"
        else
            echo -e "${CL_RED}Skipped generating json for a Unofficial build${CL_NC}"
        fi
    fi
fi