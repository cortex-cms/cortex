module Tree
  def self.recursive_search(tree_array, ids = [])
    tree_array.each do |hash_val|
      ids << hash_val[:id]
      if hash_val[:children].any?
        Tree.recursive_search(hash_val[:children], ids)
      end
    end

    ids
  end
end
