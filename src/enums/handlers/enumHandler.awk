BEGIN {
  previousEnumValue = "";
  previousRowValue = "";
  OFS = ",";
}

{
  rowValue = $0;

  if (isDescriptionTag(rowValue)) {
    descriptionTag = getDescriptionTag(rowValue);
  }

  if (isEnumValue(previousRowValue, rowValue)) {
    split(getEnumValue(rowValue, previousEnumValue), result, "&");
    key = trim(result[1]);
    value = removeQuotes(result[2]);

    previousEnumValue = value;

    print value, key, descriptionTag;
  }

  previousRowValue = rowValue;
}
