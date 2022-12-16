#!/bin/bash

### .env File:
source ${PWD}/.env

### Input Variables:
source=$1;

### Definitions:
tmpFile=".tmp.csv";

### Source Code:

basename=$(echo ${source} | gawk -i ${PWD}/src/enums/utils/functions.awk  '{ split($0, result, "/"); basename=result[length(result)]; sub(".cs", "", basename); print getCamelCase(basename); }');

outputFile="assets/${basename}.json";

gawk -i ${PWD}/src/enums/utils/functions.awk -f ${PWD}/src/enums/handlers/enumHandler.awk ${source} > ${tmpFile};

node ${PWD}/src/enums/handlers/outputFormatter.js ${tmpFile} > ${outputFile};

rm ${tmpFile};
