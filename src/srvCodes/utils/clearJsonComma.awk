{
  if (NR >= (numberOfLines - 1)) {
    result = $0;
    sub(",", "", result);
    print result;
  } else {
    print $0;
  }
}
