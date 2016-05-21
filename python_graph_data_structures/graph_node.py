class GraphNode:
  """Implementation of a node in a graph with an arbitrary amount of neighbors
  via an adjacency list. A node has a key, value, and a collection of edges
  that contain node key values.
  """

  def __init__(self, k, v):
    """GraphNode class constructor.

    Keyword arguments:
    k - the node/vertex key
    v - the node/vertex value
    """

    self.key = k
    self.value = v
    self.__edges = []

  def num_edges(self):
    """Returns the total number of outbound edges."""

    return len(self.__edges)

  def has_edge(self, k):
    """Determines if the node has an edge to another node by some key."""

    return k in self.__edges

  def add_edge(self, k):
    """Appends (connects) a vertex to the node by the connecting nodes key.

    Keyword arguments:
    k - the connecting nodes key
    """

    self.__edges.append(k)

    return self

  def remove_edge(self, k):
    """Removes an edge from the node by the connecting nodes key.

    Keyword arguments:
    k - the connecting nodes key
    """

    if k in self.__edges:
      self.__edges.remove(k)

    return self

  def edges(self):
    """A generator to provide iteration over each connected vertex of a node.
    """

    for edge in self.__edges:
      # yield the connecting nodes key
      yield edge
