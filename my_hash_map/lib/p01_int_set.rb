class MaxIntSet
  def initialize(max)
    @store = Array.new(max+1) { false }
  end

  def insert(num)
    raise "Out of bounds" if @store.length <= num || num < 0
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self[num].include?(num)
  end

  def remove(num)
    self[num].delete(num) if self[num].include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    bucket = num % num_buckets
    @store[bucket]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count == num_buckets
    unless self[num].include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
      return true
    end
    false
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    bucket = num % num_buckets
    @store[bucket]
  end

  def num_buckets
    @store.length
  end

  def resize!
    store_dup = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |num|
        new_bucket = num % store_dup.length
        store_dup[new_bucket] << num
      end
    end
    @store = store_dup
  end
end
