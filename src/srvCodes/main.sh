#!/bin/bash

source ${PWD}/.env

# Variables definitions
TEMP=".tmp";
jsonCodes=${TEMP}"/srvCodes.json";
jsonMessages=${TEMP}"/srvMessages.json";
tempFile=${TEMP}"/tmp.json";
outputFile="./assets/srvTunaCodes.json";

# Init temporary folder
mkdir ${TEMP} 2> /dev/null;

# Auxiliary functions to produce JSON files
function getNumberOfLines() {
    echo $(wc -l $1 | gawk '{ print $1; }');
}

function clearJsonComma() {
    jsonFile=$1;
    numberOfLines=$(getNumberOfLines ${jsonFile});
    gawk -f "./src/srvCodes/utils/clearJsonComma.awk" -v numberOfLines=${numberOfLines} ${jsonFile};
}

# Process CS_SRV_CODES to get its code keys and code values
gawk -f "./src/srvCodes/utils/srvCodes.awk" ${CS_SRV_CODES} \
  | gawk -f "./src/srvCodes/utils/srvCodesToJson.awk" \
  | sed 's/description/code/g' \
  > ${tempFile};

clearJsonComma ${tempFile} \
  > ${jsonCodes};

# Process CS_SRV_MESSAGES to get its messages based on code keys
gawk -f "./src/srvCodes/utils/srvMessages.awk" ${CS_SRV_MESSAGES} \
  | gawk -f "./src/srvCodes/utils/srvMessagesToJson.awk" \
  > ${tempFile};

clearJsonComma ${tempFile} \
  > ${jsonMessages};

# Generate output with code keys, code messages, and messages
node "./src/srvCodes/utils/outputFormatter.js" ${jsonCodes} ${jsonMessages} > ${outputFile};
echo "Generated file: ${outputFile}";

# Remove temporary folder
rm -rf ${TEMP};
