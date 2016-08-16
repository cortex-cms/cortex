class CategoryTree

  def self.category_data
    [{category: "Candidate Experience", category_id: "1"}, {category: "Recruitment Techniques", category_id: "2"}, {category: "Talent Sourcing", category_id: "3"}, {category: "Hiring Strategy", category_id: "4"}, {category: "Data and Analytics", category_id: "5"}, {category: "Recruitment Technology", category_id: "6"}, {category: "Workplace Insights", category_id: "7"}, {category: "News and Trends", category_id: "8"}]
  end

  def self.audience_data
    [{category: "Job Seeker", category_id: "1"}, {category: "Employer", category_id: "2"}]
  end

  def self.onet_data
    Onet::Occupation.first(10).map.with_index do |onet_code, i|
      {category: onet_code.title, category_id: i}
    end
  end

  def self.persona_data
    [{category: "Persona 1", category_id: "1"}, {category: "Persona 2", category_id: "2"}]
  end

  def self.vertical_data
    [{category: "Small Business", category_id: "1"}, {category: "Recruiting & Staffing", category_id: "2"}, {category: "Health Care", category_id: "3"}]
  end

  def self.research_data
    [{category: "Third Party Research", category_id: "1"}, {category: "CB Research", category_id: "2"}]
  end

  def self.build(data)
    data.inject(Tree.new) do |tree, node|
      tree.add_node(node)
      tree
    end
  end

end
