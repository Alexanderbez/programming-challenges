class BinaryNode:
  """Implementation of a node in a binary tree."""

  def __init__(self, k, v, lc=None, rc=None):
    """BinaryNode class constructor.

    Keyword arguments:
    v - the node key
    v - the node value
    lc - the node's left child (None by default)
    rc - the node's right child (None by default)
    """

    self.key = k
    self.value = v
    self.left_child = lc
    self.right_child = rc

  def is_leaf(self):
    """Determines if the node is a leaf node or not."""

    return False if self.left_child or self.right_child else True
