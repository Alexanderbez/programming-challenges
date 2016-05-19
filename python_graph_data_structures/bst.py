from binary_node import BinaryNode
from binary_tree import BinaryTree
from sys import maxsize

class BinarySearchTree(BinaryTree):

  def __insert_aux(self, k, v, node):
    """Inserts a node into the binary search tree with a key value while
     maintaining the fundamental properties of a binary search tree. If a key
     already exists in the tree, it's value is updated.

    Time complexity: O(logn) (Average)

    Keyword arguments:
    k - the node key
    v - the node value
    node - the current node
    """

    if not node:
      self.size += 1

      return BinaryNode(k, v)
    elif k == node.key:
      # Existing node exists with the key, so update the value
      return BinaryNode(k, v, node.left_child, node.right_child)
    elif k <= node.key:
      # Insert into left sub-tree
      return BinaryNode(
        node.key,
        node.value,
        self.__insert_aux(k, v, node.left_child),
        node.right_child
      )
    else:
      # Insert into right sub-tree
      return BinaryNode(
        node.key,
        node.value,
        node.left_child,
        self.__insert_aux(k, v, node.right_child)
      )

  def insert(self, k, v):
    self.root = self.__insert_aux(k, v, self.root)

    return self.root

  def get_min(self, node=None):
    """Gets the smallest node by value of the tree rooted at a node by finding
    it's left most child.

    Keyword arguments:
    node - the current node
    """

    if not node:
      node = self.root

    while node and node.left_child:
      node = node.left_child

    return node

  def get_max(self, node=None):
    """Gets the largest node by value of the tree rooted at a node by finding
    it's right most child.

    Keyword arguments:
    node - the current node
    """

    if not node:
      node = self.root

    while node and node.right_child:
      node = node.right_child

    return node

  def __remove_aux(self, k, node, d_side=0):
    """Attempts to remove a node in the binary search tree by searching for a
    matching key value and returns that removed node. The tree is modified in
    place. If no such node is found, then None is returned.

    Time complexity: O(logn) (Average)

    Keyword arguments:
    k - the key of the node to remove
    node - the current node
    d_side - determines what side to attempt to delete from (0|1)
    """
    if node:
      if k < node.key:
        # Search left sub-tree
        return BinaryNode(
          node.key,
          node.value,
          self.__remove_aux(k, node.left_child),
          node.right_child
        )
      elif k > node.key:
        # Search right sub-tree
        return BinaryNode(
          node.key,
          node.value,
          node.left_child,
          self.__remove_aux(k, node.right_child)
        )
      else:
        # Found the node to remove
        # Check for one of three cases:
        # 1. The node is a leaf
        # 2. The node has only one child
        # 3. The node has two children

        if node.left_child and node.right_child:
          # Internal node
          successor = self.get_min(node.right_child)
          predecessor = self.get_max(node.left_child)

          # On each node removal, attempt to alternate between sides
          if (d_side == 0 and predecessor) or (d_side == 1 and not successor):
            node.key = predecessor.key
            node.value = predecessor.value

            return BinaryNode(
              node.key,
              node.value,
              self.__remove_aux(predecessor.key, node.left_child, ~d_side),
              node.right_child
            )
          elif (d_side == 1 and successor) or (d_side == 0 and not predecessor):
            node.key = successor.key
            node.value = successor.value

            return BinaryNode(
              node.key,
              node.value,
              node.left_child,
              self.__remove_aux(successor.key, node.right_child, ~d_side)
            )

        else:
          self.size -= 1

          if node.left_child:
            # Swap with left child
            return node.left_child
          elif node.right_child:
            # Swap with right child
            return node.right_child

  def remove(self, k):
    if not self.is_empty():
      self.root = self.__remove_aux(k, self.root)

    return self.root

  def __find_aux(self, k, node):
    """Attempts to find a node in the binary search tree who's key equals some
    value. If no such node is found, then None is returned.

    Time complexity: O(logn) (Average)

    Keyword arguments:
    k - the key to search for
    node - the current node
    """

    if not node or node.key == k:
      # The node was found or we've exhausted the search path
      return node
    elif k <= node.key:
      # Search left sub-tree
      return self.__find_aux(k, node.left_child)
    else:
      # Search the right sub-tree
      return self.__find_aux(k, node.right_child)

  def find(self, k):
    return self.__find_aux(k, self.root)

  def __is_valid_aux(self, node, min_val, max_val):
    """Determines if the binary tree rooted at `node` is a valid binary search
    tree.

    Time complexity: O(n)

    Keyword arguments:
    node - the current node
    min_val - the minimum node key encountered
    max_val - the maximum node key encountered
    """

    if not node:
      return True
    elif (node.key < min_val) or (node.key > max_val):
      return False
    else:
      x = self.__is_valid_aux(node.left_child, min_val, node.key)
      y = self.__is_valid_aux(node.right_child, node.key, max_val)

      return x and y

  def is_valid(self):
    return self.__is_valid_aux(self.root, (~maxsize - 1), maxsize)
