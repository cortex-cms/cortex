json.partial! category
unless category.leaf?
  json.children category.children do |child|
    json.partial! 'categories/category_with_children', category: child
  end
end