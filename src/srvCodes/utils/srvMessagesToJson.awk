BEGIN {
  LINE_OFFSET = 5;
  isPrinting = 1;
  print "{";
}

{
  if (match($0, /SRV/)) {
    newSrv = $0;
    isPrinting = 1;
  }

  if (substr($0, 0, 2) == "EN") {
    en = substr($0, LINE_OFFSET, length($0));
    hasEN = 1;
    isPrinting = 0;
  }

  if (substr($0, 0, 2) == "PT") {
    pt = substr($0, LINE_OFFSET, length($0));
    hasPT = 1;
    isPrinting = 0;
  }

  if (NR == 1) {
    srvCodes = newSrv;
  } else if (isPrinting == 1) {
    print "  \""srvCodes"\": {";
    print "    \"EN\": \""en"\",";
    print "    \"PT\": \""pt"\"";
    print "  },"

    if (hasEN == 0 || hasPT == 0) {
      print;
      print ">>> WARNING FOR:", srvCodes;
      print;
    }

    srvCodes = newSrv;
    hasEN = 0;
    hasPT = 0;
  }
}

END {
  if (hasEN == 1 || hasPT == 1) {
    print "  \""srvCodes"\": {";
  }

  if (hasEN == 1) {
    print "    \"EN\": \""en"\",";
  }

  if (hasPT == 1) {
    print "    \"PT\": \""pt"\"";
  }

  if (hasEN == 1 || hasPT == 1) {
    print "  },"
  }

  print "}";
}
