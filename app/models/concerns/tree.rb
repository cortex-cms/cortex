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

  def self.recursively_gather_names(tree_array, ids, names=[])
    tree_array.each do |hash_val|
      if ids.empty?
        return names
      elsif ids.include?(hash_val[:id])
        names << hash_val[:name]
        ids.delete(hash_val[:id])
      end

      if hash_val[:children].any?
        Tree.recursively_gather_names(hash_val[:children], ids, names)
      end
    end

    names
  end
end
