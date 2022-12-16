BEGIN {
  previousEnumValue = "";
  previousRowValue = "";
  OFS = ",";
}

{
  rowValue = $0;

  if (isCodeNotation(rowValue)) {
    descriptionTag = getDescriptionTag(rowValue);
  }

  if (isEnumValue(previousRowValue, rowValue)) {
    split(getEnumValue(rowValue, previousEnumValue), result, "&");
    key = trim(result[1]);
    value = result[2];

    previousEnumValue = value;

    print value, key, descriptionTag;
  }

  previousRowValue = rowValue;
}
