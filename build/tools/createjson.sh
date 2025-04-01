#!/bin/bash

CL_RED="\033[31m"
CL_CYN="\033[1;36m"
CL_PRP="\033[35m"
CL_NC="\033[0m"

[ -z "$1" ] && exit 0

echo "Generating .json"
file_path="$1"
file_name=$(basename "$file_path")
DEVICE=$(echo "$TARGET_PRODUCT" | sed 's/aosp_//g')

[ ! -f "$file_path" ] && exit 0

build_props="./out/target/product/$DEVICE/system/build.prop"

if [[ "$file_name" =~ "OFFICIAL" ]] || [[ "$FORCE_JSON" == 1 ]]; then
    [[ "$FORCE_JSON" == 1 ]] && echo -e "${CL_CYN}Forced generation of json${CL_NC}"

    file_size=$(stat -c %s "$file_path")
    sha256=$(sha256sum "$file_path" | cut -d' ' -f1)
    datetime=$(grep -w "ro\\.build\\.date\\.utc=.*" "$build_props" | cut -d= -f2)
    version=$(echo "$file_name" | grep -o "[0-9]\.[0-9]" | head -n1)
    link="https://sourceforge.net/projects/pixel-project/files/${DEVICE}/${file_name}/download"

    cat > "$file_path.json" << EOF
{
  "response": [
    {
      "datetime": $datetime,
      "filename": "$file_name",
      "id": "$sha256",
      "size": $file_size,
      "url": "$link",
      "version": "$version"
    }
  ]
}
EOF

    mv "$file_path.json" "./${DEVICE}.json"
    echo -e "${CL_CYN}Done generating ${CL_PRP}${DEVICE}.json${CL_NC}"
else
    echo -e "${CL_RED}Skipped generating json for a non-official build${CL_NC}"
fi
