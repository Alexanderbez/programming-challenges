from linked_list import LinkedList

class Stack:
  """Basic stack (LIFO) implementation using a singly linked list"""

  def __init__(self):
    """Stack constructor"""

    self.__list = LinkedList()

  def size(self):
    """Determines the size of the stack

    Time complexity: O(1)
    """

    return self.__list.size

  def empty(self):
    """Determines if the stack is empty or not

    Time complexity: O(1)
    """

    return self.__list.empty()

  def push(self, data):
    """Pushes an item onto the stack (head)

    Time complexity: O(1)
    """

    return self.__list.addHead(data)

  def pop(self):
    """Removes an item off of the stack (head)

    Time complexity: O(1)
    """

    return self.__list.remove(0) if not self.empty() else None

  def pretty_print(self):
    """Pretty prints the stack in the following format:
    (head) -> ... -> (tail)
    """

    self.__list.pretty_print()
