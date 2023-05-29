# This is an array based queue.
# # Items in the queue can be required to be unique
# insert: O(log(queue size)), find_highest: O(1), pull_highest: O(1)
class PriorityQueueArray
  attr_reader :queue

  def initialize
    @queue = [] # list of items ordered by priority then insertion order. Can force uniqueness.
  end

  def insert(item)
    # return unless unique?(item)
    index = @queue.bsearch_index {|e| e.priority >= item.priority } || -1
    @queue.insert(index, item)
  end
  alias_method :<<, :insert

  #NOTE: Deletes from Queue and returns FIRST item inserted at HIGHEST Priority - FIFO
  def pull_highest
    return nil if @queue.empty?
    @queue.pop
  end

  #Note: Returns FIRST item inserted at HIGHEST Priority - FIFO
  def find_highest
    @queue.last
  end

  def empty?
    @queue.empty?
  end

  def size
    @queue.length
  end

  def clear
    @queue.clear
  end

# Extensions
  #NOTE: Deletes from Queue and returns LAST item inserted at LOWEST Priority - LIFO
  def pull_lowest
    return nil if @queue.empty?
    @queue.shift
  end

  #Note: Returns LAST item inserted at LOWEST Priority - LIFO
  def find_lowest
    @queue.first
  end

  def to_s
    @queue.map { |e| "#{e.to_s} (#{e.priority})" }.join(", ")
  end

private
  def unique?(item)
    @queue.any? {|member| member.equal? item }
  end
end
