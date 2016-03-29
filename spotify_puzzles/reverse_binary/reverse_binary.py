import sys

__author__ = "Alexander Bezobchuk"
__email__ = "abezobchuk@gmail.com"

def get_input():
    """Fetches user input from stdin"""
    
    if (len(sys.argv) > 1):
        return sys.argv[1]
    else:
        return raw_input('')

def reverse_binary(n):
    """Reverses a number via a binary representation.

    Keyword arguments:
    n -- the number to reverse
    """

    # Parse and validate input
    try:
        n, r, bits = int(n), 0, []

        if (n < 1 or n > 1000000000):
          raise
    except Exception, e:
        print 'Error: Invalid input'
        exit()

    # Convert to base 2 (binary)
    while (n > 0):
        bits.append(n % 2)
        n /= 2

    # Reverse in order to multiply bits correctly
    bits.reverse()

    # Convert back to base 10
    for i, bit in enumerate(bits):
        r += bit * (2 ** i)

    return r

n = get_input()
r = reverse_binary(n)

print r
