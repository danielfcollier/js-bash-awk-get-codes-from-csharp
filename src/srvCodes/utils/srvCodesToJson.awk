function prettyPrint(code, description) {
  print "  \""code"\": {";
  print "    \"description\": \""description"\"";
  print "  },"
}

BEGIN {
  print "{";
  if (swapOrder != 1 || swapOrder == 0) {
    swapOrder = 0;
  }
}

{
  isSwapped = swapOrder == 1;

  if (NR % 2 == 1) {
    data[0] = $0;
  } else {
    data[1] = $0;

    if (isSwapped) {
      code = data[1];
      description = data[0];
    } else {
      code = data[0];
      description = data[1];
    }
    prettyPrint(code, description);
  }

  if (swapOrder == 1) {
    description = $0;
    code = $0;
  }
}

END {
  print "}";
}
