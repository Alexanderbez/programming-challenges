class Hashie:
  """Basic hash table implementation"""

  def __init__(self):
    """Hashie constructor. The hash table size is always a power of two and the
    load factor is 0.75.
    """

    self.size = 0
    self.__init_capacity = 1024
    self.__load_factor = 0.75
    self.__capacity = self.__init_capacity
    self.__table = [None] * self.__init_capacity

  def set(self, key, value):
    """Associates the specified value with the specified key in the table. If
    a collision occurs, then the `chaining` method is used to group values. The
    table is also resized once the size of the table has exceeded the load
    factor.

    Keyword arguments:
    key -- the associated key to be inserted
    value -- the associated value to be inserted
    """

    hash_value = self.__hash(key)
    bucket = self.__table[hash_value]
    new_node = (key, value)

    if bucket:
      """Bucket exists, meaning we have a collision. If the key already exists,
      then the existing value is replaced. Otherwise, the new key, value pair
      is appended to the bucket.
      """
      node = next((n for n in bucket if n[0] == key), None)

      if node:
        idx = bucket.index(node)
        bucket[idx] = new_node
      else:
        bucket.append(new_node)
        self.size += 1
    else:
      self.__table[hash_value] = [new_node]
      self.size += 1

    # Resize the table if the size exceeds the load factor
    if float(self.size) / self.__capacity >= self.__load_factor:
      self.__resize()

    return value

  def get(self, key):
    """Attempts to retrieve the value for an associated key in the table. If no
    key exists in the table, then None is returned.

    Keyword arguments:
    key -- the key to lookup in the table
    """

    hash_value = self.__hash(key)
    bucket = self.__table[hash_value]
    value = None

    """Find the value in the bucket. Assuming there are no collisions, this is
    a O(c) operation.
    """
    if bucket:
      node = next((n for n in bucket if n[0] == key), None)

      if node:
        value = node[1]

    return value

  def remove(self, key):
    """Removes the key and it's associated value from the hash table. The table
    is not shrunk if the table size is less than the initial capacity. If the
    key is found, the value will be returned.

    Keyword arguments:
    key -- the key to remove from the hash table
    """

    hash_value = self.__hash(key)
    bucket = self.__table[hash_value]
    value = None

    if bucket:
      node = next((n for n in bucket if n[0] == key), None)

      if node:
        # Set value and delete node from list
        value = node[1]
        bucket.remove(node)
        self.size -= 1

        # Reset hash table value if the list is empty
        if not bucket:
          self.__table[hash_value] = None

    return value

  def __hash(self, key):
    """Determines a hash value using a hashing function given a specified key
    that is to be used to determine the location in the hash table. The FNV-1a
    hashing function is used. A ID of the object (key) is used to build the
    hash value.

    Reference: http://www.isthe.com/chongo/tech/comp/fnv/#FNV-1a

    Keyword arguments:
    key -- the key value to perform the hash function on
    """

    # 64-bit FNV prime
    fnv_prime = 1099511628211

    # 64-bit FNV offset (initial hash value)
    hash_value = 14695981039346656037

    for x in str(id(key)):
      hash_value ^= int(x)
      hash_value *= fnv_prime

    return hash_value % self.__capacity

  def __resize(self):
    """Resizes the current hash table by doubling it's size. Every existing key
    in the table is then re-hashed and moved accordingly based upon it's new
    hash value.
    """

    new_capacity = 0
    old_capacity = self.__capacity
    capacity = self.__capacity

    # Compute log2(capacity)
    while capacity > 1:
      capacity >>= 1
      new_capacity += 1

    # Increase current capacity power by one
    new_capacity = 2 ** (new_capacity + 1)

    # Increase table size and set new capacity
    self.__table.extend([None] * (new_capacity - self.__capacity))
    self.__capacity = new_capacity

    # Rehash existing keys (only iterating over old table size)
    for i in range(old_capacity):
      bucket = self.__table[i]

      if bucket:
        key = bucket[0][0]
        hash_value = self.__hash(key)

        # Delete bucket from existing index (hash value)
        self.__table.remove(bucket)

        # Set bucket in new index (hash value)
        self.__table[hash_value] = bucket

    return
