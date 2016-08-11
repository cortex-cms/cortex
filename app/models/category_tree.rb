class CategoryTree

  @data = [{category: "Candidate Experience", category_id: "1"}, {category: "Recruitment Techniques", category_id: "2"}, {category: "Talent Sourcing", category_id: "3"}, {category: "Hiring Strategy", category_id: "4"}, {category: "Data and Analytics", category_id: "5"}, {category: "Recruitment Technology", category_id: "6"}, {category: "Workplace Insights", category_id: "7"}, {category: "News and Trends", category_id: "8"}]

  def self.build(data = @data)
    data.inject(Tree.new) do |tree, node|
      tree.add_node(node)
      tree
    end
  end

end
