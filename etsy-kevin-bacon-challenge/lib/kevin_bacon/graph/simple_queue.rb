module KevinBacon
  class SimpleQueue
    extend Forwardable

    attr_reader :queue

    # Initializes a simple Queue object by wrapping an Array with delegators to
    # provide the expected queue operations.
    #
    # @return [KevinBacon::SimpleQueue]
    def initialize
      @queue = []
    end

    # Delegate the enqueue operation
    def_delegator :@queue, :push, :enqueue
    # Delegate the dequeue operation
    def_delegator :@queue, :shift, :dequeue
    # Delegate some basic auxiliary operations
    def_delegators :@queue, :size, :length, :count, :clear, :empty?, :any?
  end
end
