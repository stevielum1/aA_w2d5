require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    unless self[key].include?(key)
      self[key] << key
      @count += 1
    end
  end

  def remove(key)
    if self[key].include?(key)
      self[key].delete(key)
      @count -= 1
      return true
    end
    false
  end

  def include?(key)
    self[key].include?(key)
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    bucket = key.hash % num_buckets
    @store[bucket]
  end


  def num_buckets
    @store.length
  end

  def resize!
    store_dup = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |key|
        new_bucket = key.hash % store_dup.length
        store_dup[new_bucket] << key
      end
    end
    @store = store_dup
  end

end
