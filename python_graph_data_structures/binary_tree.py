from binary_node import BinaryNode
from queue import Queue

class BinaryTree:
  """A balanced binary tree implementation"""

  def __init__(self):
    """BinaryTree class constructor"""

    self.size = 0
    self.root = None

  def is_empty(self):
    """Determines if the binary tree is empty.

    Time complexity: O(1)
    """

    return False if self.root else True

  def insert(self, k, v):
    """Inserts a node into the binary tree. A node is inserted at the bottom
    most level using BFS to find the correct spot in order to keep the tree
    balanced.

    Time complexity: O(n)

    Keyword arguments:
    k - key of node
    v - value of node
    """

    node = BinaryNode(k, v)

    if not self.root:
      self.root = node
    else:
      # Perform BFS for the first empty spot to insert the new node
      queue = Queue()

      queue.enqueue(self.root)

      while not queue.is_empty():
        n = queue.dequeue()

        if n.left_child and n.right_child:
          # n is an internal node (keeps binary structure)
          queue.enqueue(n.left_child)
          queue.enqueue(n.right_child)
        else:
          # Add child
          if n.left_child:
            n.right_child = node
          else:
            n.left_child = node

          # Empty queue out as to not continue processing further nodes
          queue.clear()

    self.size += 1

    return node

  def __in_order_traversal_aux(self, node):
    """Prints all the nodes in the tree via in order traversal.

    In order traversal: left child node, current node, right child node

    Time complexity: O(n)

    Keyword arguments:
    node - the current node
    """

    if node:
      self.__in_order_traversal_aux(node.left_child)
      print('(%d, %d)' % (node.key, node.value))
      self.__in_order_traversal_aux(node.right_child)

  def in_order_traversal(self):
    self.__in_order_traversal_aux(self.root)

  def __pre_order_traversal_aux(self, node):
    """Prints all the nodes in the graph via pre order traversal.

    Pre order traversal: current node, left child node, right child node

    Time complexity: O(n)

    Keyword arguments:
    node - the current node
    """

    if node:
      print('(%d, %d)' % (node.key, node.value))
      self.__pre_order_traversal_aux(node.left_child)
      self.__pre_order_traversal_aux(node.right_child)

  def pre_order_traversal(self):
    self.__pre_order_traversal_aux(self.root)

  def __post_order_traversal_aux(self, node=None):
    """Prints all the nodes in the graph via post order traversal.

    Post order traversal: left child node, right child node, current node

    Time complexity: O(n)

    Keyword arguments:
    node - the current node
    """

    if node:
      self.__post_order_traversal_aux(node.left_child)
      self.__post_order_traversal_aux(node.right_child)
      print('(%d, %d)' % (node.key, node.value))

  def post_order_traversal(self):
    self.__post_order_traversal_aux(self.root)
