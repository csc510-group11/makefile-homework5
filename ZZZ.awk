BEGIN {
    FS = "[ \t\n,.!?;:]+"
    OFS = ","
}

# First Pass: Read the top words from top.txt
PASS == 1 {
    top_words[FNR] = $1  # Store words in an array
    next
}

# Second Pass: Process cleaned.txt and count occurrences of top words per paragraph
PASS == 2 {
    if (FNR == 1) {
        # Print the top words at the beginning of pass 2
        for (i = 1; i <= length(top_words); i++) {
            printf "%s%s", top_words[i], (i == length(top_words) ? "\n" : OFS)
        }
    }
    if (NF == 0) {
        # Print the word counts for the current paragraph
        for (i = 1; i <= length(top_words); i++) {
            printf "%d%s", word_count[top_words[i]], (i == length(top_words) ? "\n" : OFS)
        }

        # Reset the word counts for the next paragraph
        delete word_count
    } else {
        # Tokenize and count occurrences
        for (i = 1; i <= NF; i++) {
            for (j in top_words) {
                if ($i == top_words[j]) {
                    word_count[$i]++
                }
            }
        }
    }
}

END {
    # Print the word counts for the last paragraph if it exists
    if (PASS == 2 && length(word_count) > 0) {
        for (i = 1; i <= length(top_words); i++) {
            printf "%d%s", word_count[top_words[i]], (i == length(top_words) ? "\n" : OFS)
        }
    }
}