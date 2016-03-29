# @author - Alex Bezobchuk
# 2/17/15

# An example solution of an LRU cache algorithm. The data structure is made up
# of a Hash and a Doubly Linked List. For each (key, value) pair, the key is
# stored in the Hash and the value is a Node in a Doubly Linked List with
# pointers to previous and next Nodes. This allows for O(c) lookup and
# insertion.
#
# There are other solutions that have the same running time, such as a Queue
# and a Hash. You could also just use an old fashioned Array, but that would
# not provide O(c) insertions and lookups.
class LRUCache
  attr_reader :cache, :size
  attr_reader :head, :tail
  attr_reader :count

  def initialize(size=4)
    @size  = size # Capacity of the Cache
    @cache = {}   # Hash holding the keys (represents our Cache)
    @head  = nil  # The head pointer (LRU)
    @tail  = nil  # The tail pointer
    @count = 0    # The total number of elements in the cache
  end

  # Adds a (key, value) pair into the LRU cache if it does not already exist.
  # => nil
  def set(key, value)
    # Only insert if the key is not already present
    unless @cache.has_key?(key)
      # Create the Node
      node = Node.new(key, value)

      if @count == @size
        # Max capacity
        # Remove the head (LRU)
        # Update pointers accordingly
        @cache.delete(head.key)
        next_node = head.next
        @head = next_node
        next_node.prev = nil
        @tail.next = node
        @tail = node
      else
        if @count == 0
          # Empty Cache, so add single element
          @tail = @head = node
        else
          # Update the tail and pointers
          tail.next = node
          node.prev = tail
          @tail = node
        end

        # Update the count
        @count += 1
      end

      # Finally, insert the key and respective Node
      @cache[key] = node
    end

    return nil
  end

  # Gets the value associated with a key in the cache if it exists.
  # => value or -1
  def get(key)
    # Check if the cache has the key
    if @cache.has_key?(key)
      node = @cache[key]

      # Update pointers as neccessary
      unless @tail == node
        # No need to update if it was the last item looked up or added
        prev_node = node.prev
        next_node = node.next

        # Support two cases:
        # 1. node is the head or LRU
        # 2. node is in the middle
        if node == @head
          next_node.prev = nil
          @head = next_node
        else
          prev_node.next = next_node
          next_node.prev = prev_node
        end

        @tail.next = node
        node.prev = tail
        @tail = node
        node.next = nil
      end

      # Return the value
      return node.value
    else
      # No key found
      return -1
    end
  end

  # @override inspect
  # Pretty prints the cache in order of LRU item to the most recently used
  # item.
  def inspect
    pretty_cache = []
    curr = @head

    while not curr.nil?
      pretty_cache << {key: curr.key, value: curr.value}
      curr = curr.next
    end

    puts pretty_cache
  end

  # A Node represented in the Doubly Linked List. Each Node has a key, value
  # and pointers to the previous and next Node respectively.
  class Node
    attr_reader :key, :value
    attr_accessor :prev, :next

    def initialize(key, value)
      @key   = key
      @value = value
      @prev  = nil
      @next  = nil
    end

  end # class Node
end # class LRUCache

# -----------------------------------------------------------------------------
#
# Questions:
# 1. What is the data structure you chose to implement/build?
# - Hash + Doubly Linked List
# 2. What is the running time of set(key, value)?
# - O(c + delta)
# 3. What is the running time of get(key)?
# - O(c + delta)
#
# Let me know if I screwed anything up!!!