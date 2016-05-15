from math import floor

class MinHeap:
  """A min-heap (binary) implementation"""

  def __init__(self):
    """MinHeap class constructor"""

    self.size = 0
    self.__tree = [] # Use a list to represent the tree and it's nodes

    # Alias `min` function
    self.min = self.peek

  def is_empty(self):
    """Determines if the min-heap is empty.

    Time complexity: O(1)
    """
    return False if self.__tree else True

  def insert(self, v):
    """Inserts a node into the min-heap while maintaining the min-heap
    property.

    Time complexity: O(logn)

    Keyword arguments:
    v - integer to insert
    """

    # Add node to the end of the tree
    self.__tree.append(v)

    # Maintain the min-heap size
    self.size += 1

    # Maintain the heap property
    self.__heapify_up(self.size - 1)

    return v

  def peek(self):
    """Returns the root (min) node in the min-heap but does not remove it.

    Time complexity: O(1)
    """

    return self.__tree[0] if not self.is_empty() else None

  def remove(self):
    """Removes and returns the root (min) node in the min-heap while
    maintaining the min-heap property.

    Time complexity: O(logn)
    """

    if not self.is_empty():
      # Swap root and last child
      tmp = self.__tree[0]
      lst_child = self.__tree[self.size - 1]
      self.__tree[0] = lst_child
      self.__tree[self.size - 1] = tmp

      v = self.__tree.pop()
      self.size -= 1

      # Maintain the heap property
      self.__heapify_down(0)

      return v

  def __heapify_down(self, i):
    """Performs the heapify down operation.

    Time complexity: O(logn)

    Keyword arguments:
    i - index (node) at which to start the heapify down operation
    """

    if i < self.size - 1:
      left_child_idx = (2 * i) + 1
      right_child_idx = (2 * i) + 2
      parent = self.__tree[i]
      tmp = parent

      if left_child_idx < self.size - 1:
        left_child = self.__tree[left_child_idx]

        if left_child < parent:
          self.__tree[i] = left_child
          self.__tree[left_child_idx] = tmp

          self.__heapify_down(left_child_idx)
      if right_child_idx < self.size - 1:
        right_child = self.__tree[right_child_idx]

        if right_child < parent:
          self.__tree[i] = right_child
          self.__tree[right_child_idx] = tmp

          self.__heapify_down(right_child_idx)

  def __heapify_up(self, i):
    """Performs the heapify up operation.

    Time complexity: O(logn)

    Keyword arguments:
    i - index (node) at which to start the heapify up operation
    """

    if i > 0:
      parent_idx = floor((i - 1) / 2)
      parent = self.__tree[parent_idx]
      child = self.__tree[i]

      if child < parent:
        # Swap nodes
        tmp = parent
        self.__tree[parent_idx] = child
        self.__tree[i] = tmp

        # Recursively call heapify up on the parent
        self.__heapify_up(parent_idx)
