class CategoryTree

  @data = [{category: "Candidate Experience"}, {category: "Recruitment Techniques"}, {category: "Talent Sourcing"}, {category: "Hiring Strategy"}, {category: "Data and Analytics"}, {category: "Recruitment Technology"}, {category: "Workplace Insights"}, {category: "News and Trends"}]

  def self.build(data = @data)
    data.inject(Tree.new) do |tree, node|
      tree.add_node(node)
      tree
    end
  end

end
