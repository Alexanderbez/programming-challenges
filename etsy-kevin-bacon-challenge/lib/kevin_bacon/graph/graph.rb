module KevinBacon
  class Graph

    attr_reader :nodes

    # Initializes an instance of a KevinBacon::Graph object. This graph is an
    # cyclical undirected graph where the nodes represent actors/actresses and
    # the edges between them represent the film they've been casted in
    # together.
    #
    # The underlying implementation is a Hash (map) where each key is a node
    # (actor/actress) and the value is a child Hash (map) where the key is the
    # co-actor/actress and the value is the edge between them. In other words,
    # an adjacency list. This relationship represents two actors and/or
    # actresses working on films together.
    #
    # @return [KevinBacon::Graph]
    def initialize
      @nodes = {}
    end

    # Builds a KevinBacon::Graph instace based off of a collection of file film
    # inputs. If no path is given, an empty graph is built.
    #
    # Note: Each file must adhere to a specific format
    #
    # @param path [String]
    # @return [KevinBacon::Graph]
    def self.build(path = nil)
      graph = KevinBacon::Graph.new

      if path
        if File.directory?(path)
          Dir["#{path}/*.json"].each do |file|
            film       = JSON.parse(File.read(file))
            film_name  = film['film']['name']
            node_pairs = film['cast'].collect { |c| c['name'] }.combination(2).to_a

            node_pairs.each do |n1, n2|
              graph.add_edge(n1, n2, film_name)
            end
          end
        else
          raise ArgumentError, 'Invalid path specified'
        end
      end

      graph
    end

    # Determines the total number of nodes (N) in the KevinBacon graph.
    #
    # @return [Integer]
    def num_nodes
      @nodes.keys.count
    end

    # Determines the total number of edges (E) in the KevinBacon graph.
    #
    # @return [Integer]
    def num_edges
      (@nodes.values.collect { |v| v.values.count }).inject(:+) / 2 rescue 0
    end

    # Determines the total size of the KevinBacon graph (E + V).
    #
    # @return [Integer]
    def size
      num_nodes + num_edges
    end

    alias_method :length, :size
    alias_method :count, :size

    # Inserts an edge between two nodes into the KevinBacon graph. Each node
    # represents an actor/actress and the edge is the collection of films they
    # have played a role in together. If either node does not exist, it will be
    # created.
    #
    # @param n1 [String]
    # @param n2 [String]
    # @param edge [String]
    # @return [KevinBacon::Graph]
    def add_edge(n1, n2, edge)
      # Add edge between n1 and n2 to represent bi-directionality
      add_edge_aux(n1, n2, edge)
      # Add edge between n2 and n1 to represent bi-directionality
      add_edge_aux(n2, n1, edge)

      self
    end

    # Removes an edge (film representation) between two nodes in the KevinBacon
    # graph.
    #
    # @param n1 [String]
    # @param n2 [String]
    # @param edge [String]
    # @return [KevinBacon::Graph]
    def remove_edge(n1, n2, edge)
      # Remove edge between n1 and n2
      remove_edge_aux(n1, n2, edge)
      # Remove edge between n2 and n1
      remove_edge_aux(n2, n1, edge)

      self
    end

    # Finds the path from a start node and a search node. The search node is
    # Kevin Bacon by default. If no path is found, an empty Array is returned.
    #
    # @param root [String]
    # @param search_node [String]
    # @return [Array]
    def find_degrees(root, search_node = 'Kevin Bacon')
      bfs_trace(root, search_node)
    end

    # Builds a string formatted version of the degrees between a start node and
    # a search node in the format:
    #
    # "actor/actress <(film)> ..."
    #
    # @param root [String]
    # @param search_node [String]
    # @return [String]
    def pretty_path(root, search_node = 'Kevin Bacon')
      path     = bfs_trace(root, search_node)
      path_cnt = path.count
      path_str = ''

      path.each_with_index do |n, i|
        if (i == path_cnt - 1)
          # Add last actor/actress
          path_str += path[path_cnt - 1]
        else
          # Add actor/actress
          path_str += n
          # Add film relation (edge)
          # Note: If multiple films are present, the first will be picked
          film     = @nodes[n][path[i + 1]].first
          path_str += " <(#{film})> "
        end
      end

      path_str
    end

    # Override #to_s method for pretty printing.
    #
    # @return [String]
    def pretty_print
      JSON.pretty_generate(@nodes)
    end

    private

    # The underlying implementation of adding an edge between two nodes.
    #
    # @param n1 [String]
    # @param n2 [String]
    # @param edge [String]
    def add_edge_aux(n1, n2, edge)
      if (n = @nodes[n1])
        if n[n2]
          n[n2] << edge unless n[n2].include?(edge)
        else
          n[n2] = [edge]
        end
      else
        @nodes[n1] = {
          n2 => [edge]
        }
      end
    end

    # The underlying implementation of removing an edge between two nodes.
    #
    # @param n1 [String]
    # @param n2 [String]
    # @param edge [String]
    def remove_edge_aux(n1, n2, edge)
      if (n = @nodes[n1])
        if n[n2]
          # Remove film from edge
          n[n2].delete(edge)
          # Remove edge entirely if no relationship
          n.delete(n2) if n[n2].empty?
          # Remove node if there are no longer any relationships
          @nodes.delete(n1) if @nodes[n1].empty?
        end
      end
    end

    # Modifed breadth first search implementation keeping track of the path
    # from the root node (the actor/actress) to a search node (actor/actress).
    # If a relationship can be found (n degrees), then the path is returned.
    #
    # @param root [String]
    # @param search_node [String]
    # @return [Array]
    def bfs_trace(root, search_node)
      queue   = KevinBacon::SimpleQueue.new
      visited = Hash.new(false) # Additional O(n) space

      # Enqueue the initial node (and path containing only the root)
      queue.enqueue([root])

      # Perform BFS iteratively on the queue while maintaining paths
      while queue.any?
        path = queue.dequeue
        node = path.last

        # Mark node as visited (to avoid cyclical loops)
        visited[node] = true

        return path if node == search_node

        # Add edges to queue to keep searching in BFS order
        if (edges = @nodes[node])
          edges.keys.each do |e|
            child_path = path.dup

            if (@nodes[e] and not visited[e])
              child_path.push(e)
              queue.enqueue(child_path)
            end
          end
        end
      end

      return []
    end

  end
end
