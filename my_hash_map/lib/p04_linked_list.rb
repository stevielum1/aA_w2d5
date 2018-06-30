class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @next.prev = self.prev
    @prev.next = self.next
  end
end

class LinkedList
  attr_reader :head, :tail

  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end


  def [](i)
    each_with_index { |link, j| return link if j == i }
    nil
  end

  def length
    self.each_with_object(0) { |el, acc| acc += 1 } - 1
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    @head.next == @tail
  end

#returns value
  def get(key)
    each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = @tail.prev
    @tail.prev.next = new_node
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
    each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    each do |node|
      node.remove if node.key == key
    end
  end

  def each(&prc)
    prc ||= proc{|node| node }
    curr_node = @head.next
    until curr_node.next.nil?
      prc.call(curr_node)
      curr_node = curr_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
