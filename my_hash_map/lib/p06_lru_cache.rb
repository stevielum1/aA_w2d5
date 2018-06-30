require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count, :max
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @store.include?(key)
      update_node!(@map.get(key))
    else
      puts @store
      eject! if @store.length == max
      cache_val = @prc.call(key)
      @store.append(key, cache_val)
      cache_val
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.remove(node)
    @store.append(node.key, node.val)
  end

  def eject!
    node_to_delete = @store.head.next
    @store.remove(node_to_delete)
  end

end
