# Longest Common Subsequence
# Alex Bezobchuk
# 2/5/2015

str1 = ARGV[0]
str2 = ARGV[1]

# Dynamic programming implementation
#
# The solution is dependant upon two key principles:
# 1. The last two characters of the sequences match, then you consider
# LCS(Xn-1, Ym-1).
# 2. The last two characters of the sequences don't match, then you
# consider the max of either LCS(Xn, Ym-1) or LCS(Xn-1, Ym)
#
# Time complexity: O(mxn)
# Space complexity: O(mxn)
# Space complexity can be improved by memoization
def lcs_non_opt(str1, str2)
  # Compute the sequence lengths
  str1_len = str1.length
  str2_len = str2.length

  # One of the sequences is empty
  if str1_len == 0 or str2_len == 0
    puts 0
    return
  end

  # Create our matrix traceback table
  matrix = [Array.new(str1_len) {0}, Array.new(str2_len) {0}]

  (1...str1_len).each do |i|
    (1...str2_len).each do |j|
      puts i
      puts j
      if str1[i] == str2[j]
        # Condition 1 is satisfied
        matrix[i][j] = matrix[i-1][j-1] + 1
      else
        # Condition 2 is satisfied
        puts
        matrix[i][j] = [matrix[i-1][j], matrix[i][j-1]].max
      end
    end
  end

  puts matrix[str1_len][str2_len]
end

# Call the entry point method
lcs_non_opt(str1, str2)
