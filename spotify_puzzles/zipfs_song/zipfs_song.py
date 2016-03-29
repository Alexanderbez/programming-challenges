import heapq
import sys

__author__ = "Alexander Bezobchuk"
__email__ = "abezobchuk@gmail.com"

def perform_zipfs(n, m):
    """Determines the top best songs on an album.
    Note: Only O(m) space is used.

    Keyword arguments:
    n -- the number of songs on the album
    m -- the number of best songs to find
    Returns:
    A list of Tuples in ascending order of qi value. Each Tuple has the qi
    value, the song name, and the order in the album.
    """

    if (n > 50000 or n < 1):
      exit()
    elif (m > n or m < 1):
      exit()

    heap = []

    for i in range(n):
      # Get raw input from stdin
      raw = sys.stdin.readline().rstrip().split()

      # Compute qi from given fi and zi (via Zipfs law)
      fi = float(raw[0])
      zi = 1 / (float(i) + 1)
      qi = fi / zi

      # Song name
      name = raw[1]

      '''
      Use a minheap to determine top qi values and keep space to O(m).
      '''
      # Song Tuple of (qi, name, sequence order)
      song = (qi, name, i + 1)

      if len(heap) < m:
        heapq.heappush(heap, song)
      elif heap[0][0] <= qi:
        heapq.heapreplace(heap, song)

    '''
    We could just pop each element off the heap and return a reversed list.
    However, we want to keep initial sequence order for songs with the same
    qi values.
    '''
    return sorted(heap, key = lambda song: (song[0], -song[2]))

'''
Fetch n (number of songs on the album) and m (number of songs to select) from
stdin.
'''
raw = sys.stdin.readline().rstrip().split()
n = int(raw[0])
m = int(raw[1])

'''
Determine the m best songs on an album with n songs while observing Zipfs law.
The top m will be returned in descending order
'''
best_songs = perform_zipfs(n, m)

# Reverse the list of Tuples (descending order) and only print the song names
print '\n'.join([song[1] for song in best_songs[::-1]])
