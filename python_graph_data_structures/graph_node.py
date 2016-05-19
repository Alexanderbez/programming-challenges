class GraphNode:
  """Implementation of a node in an undirected graph with an arbitrary amount
  of vertices.
  """

  def __init__(self, v):
    self.data = v
    self.__vertices = []
    self.__num_vertices = 0

  def append_vertex(self, node):
    """Appends (connects) a vertex to the node.

    Keyword arguments:
    node - a GraphNode object
    """

    self.__vertices.append(node)
    self.__num_vertices += 1

    return node

  def vertices(self):
    """A generator to provide iteration over each connected vertex of a node.
    """

    for vertex in self.__vertices:
      yield vertex

  def get_vertex(self, i):
    """Gets the ith connected vertex of the node. If no vertex exists, None is
    returned.

    Keyword arguments:
    i - desired child index
    """

    return self.__vertices[i] if i < self.__num_vertices else None
