# Sample line:
#
#                {("PT","SRVPixKeyNotUsable"),"Chave pix não encontrada/válida"},
#
BEGIN {
  FS = ",";
}

NF >= 3 {
  isEN = match($0, "EN");
  isPT = match($0, "PT");
  isDictionary = match($0, /\{.*\}/);

  if (isDictionary && (isEN || isPT)) {
    match($2, /"([^""]*)"/, filterCode);
    code = substr(filterCode[0], 2, length(filterCode[0]) - 2);

    content = "";
    for (i = 3; i <= NF; i++) {
      content = content " " $i;
    }

    match(content, /"([^""]*)"/, filterDescription);
    description = substr(filterDescription[0], 2, length(filterDescription[0]) - 2);

    if (isEN) {
      descriptionEN = description;
    }

    if (isPT) {
      descriptionPT = description;

      print code;
      print "EN: " descriptionEN;
      print "PT: " descriptionPT;
    }
  }
}
