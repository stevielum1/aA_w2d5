require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end
  
  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    node = @store[bucket(key)]
    unless node.include?(key)
      resize! if count == num_buckets
      node.append(key, val)
      @count += 1
    else
      node.update(key, val)
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each(&prc)
    prc ||= proc { |k, v| [k, v] }
    @store.each do |bucket|
      bucket.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    store_dup = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |bucket|
      bucket.each do |node|
        new_bucket_idx = node.key.hash % store_dup.length
        store_dup[new_bucket_idx].append(node.key, node.val)
      end
    end
    @store = store_dup
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
