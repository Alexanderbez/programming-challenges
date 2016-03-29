# Longest Common Subsequence Problem

Given two strings with characters in the same alphabet {a<sub>1</sub>...a<sub>i</sub>}, find the length of the largest common subsequence.

A subsequence in two or more strings is defined as: "A sequence that appears in the same relative order, but not necessarily contiguous."

Example:

`A = "ZXCSDFWER"`<br>
`B = "ZTTTER"`

The LCS = `"ZER"` of length `3`

Example execution:

```shell
$ ruby example_solution.rb "ZXCSDFWER" "ZTTTER"
$ 3
```

Questions:

1. What the runtime complexity
2. What is the space complexity
3. What kind of 'problem' is this
4. What kind of improvments can be done
5. Write a method that actually prints the LCS subsequence
