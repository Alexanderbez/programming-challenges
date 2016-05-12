from linked_list import LinkedList

class Queue:
  """Basic queue (FIFO) implementation using a singly linked list"""

  def __init__(self):
    """Queue constructor"""

    self.__list = LinkedList()

  def dequeue(self):
    """Removes an item of the front of the queue (head)

    Time complexity: O(1)
    """

    return self.__list.remove(0) if not self.empty() else None

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

  def empty(self):
    """Determines if the queue is empty or not

    Time complexity: O(1)
    """

    return self.__list.empty()

  def pretty_print(self):
    """Pretty prints the queue in the following format:
    (head) -> ... -> (tail)
    """

    self.__list.pretty_print()
