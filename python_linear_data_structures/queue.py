from linked_list import LinkedList

class Queue:
  """Basic queue (FIFO) implementation using a singly linked list"""

  def __init__(self):
    """Queue constructor"""

    self.__list = LinkedList()

  def peek(self):
    """Returns the node at front of the queue without removing it"""
    return self.__list.get(0) if not self.is_empty() else None

  def dequeue(self):
    """Removes an item of the front of the queue (head)

    Time complexity: O(1)
    """

    return self.__list.remove(0) if not self.is_empty() else None

  def enqueue(self, data):
    """Pushes an item onto the back of the queue (tail)

    Time complexity: O(1)
    """

    return self.__list.add(data)

  def size(self):
    """Determines the size of the queue

    Time complexity: O(1)
    """

    return self.__list.size

  def is_empty(self):
    """Determines if the queue is empty or not

    Time complexity: O(1)
    """

    return self.__list.is_empty()

  def clear(self):
    """Clears out (empties) the queue.

    Time complexity: O(1)
    """

    # Deallocate memory
    del self.__list

    # Create new linked list
    self.__list = LinkedList()

  def pretty_print(self):
    """Pretty prints the queue in the following format:
    (head) -> ... -> (tail)
    """

    self.__list.pretty_print()
