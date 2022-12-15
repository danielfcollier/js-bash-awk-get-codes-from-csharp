# Sample line:
#
#        SRVPixKeyNotUsable = -183,
#
NF == 3 {
  if (match($0, "=")) {
    code = $1;
    key = match($3, ",") ? substr($3, 0, length($3) -1) : $3;
    print key;
    print code;
  }
}
