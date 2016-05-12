class Node:
  """Linked list node implementation"""

  def __init__(self, data):
    """Node implementation

    Keyword arguments:
    data -- the node datum
    """

    self.data = data
    self.next = None

class LinkedList:
  """Basic singly linked list implementation"""

  def __init__(self):
    """LinkedList constructor"""

    self.size = 0
    self.head = None
    self.tail = None

  def add(self, v):
    """Adds a node to the end (tail) of the list"""

    node = Node(v)

    if self.empty():
      self.head = node
    else:
      self.tail.next = node

    self.tail = node
    self.size += 1

  def addHead(self, v):
    """Adds a node to the front (head) of the list"""

    node = Node(v)

    if self.empty():
      self.head = node
      self.tail = node
    else:
      node.next = self.head
      self.head = node

    self.size += 1

  def traverse(self):
    """Provides a generator to iterate over the list"""

    node = self.head

    while node:
      yield node
      node = node.next

  def remove(self, idx=None):
    """Removes a node from the end (tail) of the list if no index is specified.
    Otherwise, the node is removed at the specified index.
    """

    if idx == None:
      if self.size == 0:
        return None
      else:
        curr = self.head
        prev = self.head

        while curr.next:
          prev = curr
          curr = curr.next

        if curr == prev:
          # Remove the head as the list only contains one node
          self.head = None
          self.tail = None
        else:
          prev.next = None
          self.tail = prev

        self.size -= 1

        return curr.data
    else:
      return self.__remove_at(idx)

  def __remove_at(self, idx):
    """Removes a node at the specified index"""

    v = None

    if idx >= self.size or idx < 0:
      raise IndexError()
    elif self.size != 0:
      if idx == 0:
        # Remove the head
        tmp = self.head
        self.head = self.head.next
        tmp.next = None

        # Update tail reference if the list has only one node
        if self.size == 1:
          self.tail = None

        v = tmp.data
      else:
        i = 0
        curr = self.head
        prev = self.head

        while idx != i:
          i += 1
          prev = curr
          curr = curr.next

        prev.next = curr.next
        curr.next = None

        # Update tail reference if removing the last node
        if self.size - 1 == idx:
          self.tail = prev

        v = curr.data

      self.size -= 1

    return v

  def pretty_print(self):
    """Pretty prints the list in the following format:
    (node datum) -> (next node datum) -> ...
    """

    print(' -> '.join(map(lambda n: '(' + str(n.data) + ')', self.traverse())))

  def find(self, v):
    """Searches for a node by it's datum and returns it's index. If no node is
    found, then -1 is returned.
    """

    return next((i for i,n in enumerate(self.traverse()) if n.data == v), -1)

  def get(self, idx):
    """Returns a node at a specified at index."""

    if idx >= self.size or idx < 0:
      raise IndexError()
    else:
      return next((n for i,n in enumerate(self.traverse()) if i == idx)).data

  def empty(self):
    """Determines if the linked list is empty or not"""

    return True if self.size == 0 else False

  def reverse_iterative(self):
    """Reverses the list in place (iteratively)"""

    if self.size != 0:
      prev = None
      curr = self.head

      # Update head and tail references (by swapping references)
      tmp = self.head
      self.head = self.tail
      self.tail = tmp

      # Reverse links
      while curr:
        tmp = curr
        curr = curr.next
        tmp.next = prev
        prev = tmp

  def reverse_recursive(self, prev=None, curr=None):
    """Reverses the list in place (recursively)"""

    if not prev and not curr and self.size != 0:
      # Invoke the initial recursive call
      self.reverse_recursive(None, self.head)
    elif not curr:
      # Base case
      # Update head and tail references (by swapping references)
      tmp = self.head
      self.head = self.tail
      self.tail = tmp
    else:
      tmp = curr
      curr = curr.next
      tmp.next = prev
      prev = tmp

      self.reverse_recursive(prev, curr)
