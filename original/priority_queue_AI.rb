# Define a class for the priority queue
class PriorityQueue
  # Initialize the queue with an empty array
  def initialize
    @queue = []
  end

  # Add an element to the queue with a given priority
  def enqueue(element, priority)
    # Find the index where to insert the element
    index = @queue.index { |e| e[:priority] > priority }
    # If no such index exists, append the element to the end of the array
    index ||= @queue.length
    # Insert the element at the index
    @queue.insert(index, {element: element, priority: priority})
  end

  # Remove and return the element with the highest priority from the queue
  def dequeue
    # Return nil if the queue is empty
    return nil if @queue.empty?
    # Remove and return the first element of the array
    @queue.shift[:element]
  end

  # Return true if the queue is empty, false otherwise
  def empty?
    @queue.empty?
  end

  # Return the size of the queue
  def size
    @queue.length
  end

  # Return a string representation of the queue
  def to_s
    @queue.map { |e| "#{e[:element]} (#{e[:priority]})" }.join(", ")
  end
end

# Test the priority queue
pq = PriorityQueue.new # Create a new priority queue
pq.enqueue("A", 1) # Add element "A" with priority 1
pq.enqueue("B", 2) # Add element "B" with priority 2
pq.enqueue("C", 3) # Add element "C" with priority 3
pq.enqueue("D", 0) # Add element "D" with priority 0
puts pq # Print the queue: D (0), A (1), B (2), C (3)
puts pq.dequeue # Remove and print the highest priority element: D
puts pq.dequeue # Remove and print the next highest priority element: A
puts pq.size # Print the size of the queue: 2
puts pq.empty? # Print whether the queue is empty: false

