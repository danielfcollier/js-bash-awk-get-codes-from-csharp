function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s; }
function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s; }
function trim(s) { return rtrim(ltrim(s)); }

function getCamelCase(property) {
  firstLetter = tolower(substr(property, 1, 1));
  stringBody = substr(property, 2, length(property));
  camelCase = firstLetter stringBody;

  return camelCase;
}

function isCodeNotation(rowValue) {
  if (match(rowValue, "///")) {
    return 1;
  }

  return 0;
}

function isDescriptionTag(rowValue) {
  if (match(rowValue, "description:")) {
    return 1;
  }

  return 0;
}

function hasHiddenTag(previousValue) {
  return match(previousValue, "hide");
}

function isEnumValue(previousValue, currentValue) {
  if (!isCodeNotation(currentValue) && isDescriptionTag(previousValue)) {
    if (!hasHiddenTag(previousValue)) {
      return 1;
    }
  }

  return 0;
}

function getDescriptionTag(rowValue) {
  split(trim(rowValue), result, " ");
  descriptionTag = result[3];

  return descriptionTag;
}

function removeComma(word) {
  if (match(word, /,$/)) {
    return substr(word, 1, length(word) - 1);
  }

  return word;
}

function getEnumValue(rowValue, previousEnumValue) {
  if (match(rowValue, "=")) {
    split(trim(rowValue), result, " = ");
    key = result[1];
    value = removeComma(result[2]);

  } else {
    key = removeComma(rowValue);
    value = int(previousEnumValue) + 1;
  }

  return key "&" value;
}



