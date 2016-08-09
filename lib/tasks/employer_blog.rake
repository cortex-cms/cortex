namespace :employer_blog do
  task :seed do
    desc 'Seed Employer Blog ContentType and Fields'

    blog = ContentType.new({
      name: "Employer Blog",
      description: "Blog for Employer",
      creator_id: 1
    })
    blog.save

    blog.fields.new(name: 'Title', field_type: 'text_field_type', order_position: 1, validations: { presence: true, length: { maximum: 25, minimum: 5 } })

    blog.fields.new(name: 'Body', field_type: 'text_field_type', order_position: 2, validations: { presence: true, length: { minimum: 25 } })

    blog.fields.new(name: 'Slug', field_type: 'text_field_type', order_position: 3, validations: { presence: true })
  end
end
