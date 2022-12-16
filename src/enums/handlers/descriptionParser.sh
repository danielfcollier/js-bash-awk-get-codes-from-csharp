#!/bin/bash

### .env File:
source ${PWD}/.env;

### Input Variables:
jsonFile=$1;

### Definitions:
descriptions=${ENUMS_DESCRIPTIONS};
getDescriptions="${PWD}/assets/.getDescriptions.awk";

# First... creates an AWK function to get the descriptions:
#
echo "function getDescription(key) {" >> ${getDescriptions};
echo "  switch(key) {" >> ${getDescriptions};
cat ${descriptions} \
  | gawk -i ./src/enums/utils/functions.awk '
      {
        printf("    case \"@%s\":\n", substr($1, 1, length($1) - 1));
        description = "";
        for (i = 2; i <= NF; i++) {
          description = description " " $i;
        }
        printf("      return \"%s\";\n\n", trim(description));
  }' \
  >> ${getDescriptions};
echo "    default:" >> ${getDescriptions};
echo "      return \"Missing description for: \" key;" >> ${getDescriptions};
echo "  }" >> ${getDescriptions};
echo "}" >> ${getDescriptions};

# Now, put the descriptions in the JSON file:
#
echo "Rebuilding ${jsonFile} with descriptions...";
cat ${jsonFile} \
  | gawk -i ./src/enums/utils/functions.awk -i ${getDescriptions} '{
    rowValue = $0;
    if (match(rowValue, "\"description\":")) {
      descriptionTag = removeQuotes(trim($2));
      sub(descriptionTag, getDescription(descriptionTag), rowValue);
    }

    print rowValue;
  }' \
  > tmpFile;

cat tmpFile > ${jsonFile}
rm tmpFile ${getDescriptions} 2> /dev/null;
