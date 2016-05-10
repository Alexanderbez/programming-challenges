# Hash Table in Python

A simple hash table implementation in Python 3.

Notes:

* Hash values are computed using the FNV-1a hashing function.
* Table sizes are always a power of two.
* Resizing occurs after the load capacity is exceeded.
* Collisions are handled via lists (chaining).

## API

```python
from hashie import Hashie

h = Hashie()

h.get('foo') # >>> None
h.set('bar', 10) # >>> 10
h.size # >>> 1
h.remove('bar') # >>> 10
h.remove('foo') # >>> None
```
