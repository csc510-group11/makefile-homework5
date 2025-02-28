BEGIN {
    IGNORECASE=1
}
{ FS = " " } {
    line = "";
    for (i = 1; i <= NF; i++) {
        if ($i !~ /^(is|the|in|but|can|a|the|is|in|of|to|a|that|it|for|on|with|as|this|was|at|by|an|be|from|or|are)$/) {
            line = line $i " ";
        }
    }
    print line;
}