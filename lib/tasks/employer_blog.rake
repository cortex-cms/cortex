namespace :employer_blog do
  task seed: :environment do
    desc 'Seed Employer Blog ContentType and Fields'

    blog = ContentType.new({
      name: "EmployerBlog",
      description: "Blog for Employer",
      creator_id: 1
    })
    blog.save

    blog.fields.new(name: 'Title', field_type: 'text_field_type', order_position: 1, validations: { presence: true, length: { maximum: 25, minimum: 5 } })

    blog.fields.new(name: 'Body', field_type: 'text_field_type', order_position: 2, validations: { presence: true, length: { minimum: 100 } })

    blog.fields.new(name: 'Description', field_type: 'text_field_type', order_position: 3, validations: { presence: true, length: { minimum: 60, maximum: 120 } })

    blog.fields.new(name: 'Slug', field_type: 'text_field_type', order_position: 4, validations: { presence: true, length: { maximum: 25, minimum: 5 } })

    blog.fields.new(name: 'Author', field_type: 'user_field_type', order_position: 5, validations: { presence: true })

    blog.fields.new(name: 'Tags', field_type: 'tag_field_type', order_position: 6, validations: {})

    blog.fields.new(name: 'Publish Date', field_type: 'date_time_field_type', order_position: 7, validations: {})

    blog.fields.new(name: 'Expiration Date', field_type: 'date_time_field_type', order_position: 8, validations: {})

    # TODO: Add metadata to Categories following completion of Tree Story
    # blog.fields.new(name: 'Categories', field_type: 'tree_field_type', order_position: 9, validations: { presence: true }, metadata: {})

    blog.fields.new(name: 'SEO Title', field_type: 'text_field_type', order_position: 10, validations: { presence: true, length: { maximum: 50, minimum: 30 } })

    blog.fields.new(name: 'SEO Description', field_type: 'text_field_type', order_position: 11, validations: { presence: true, length: { maximum: 160, minimum: 100 } })

    blog.fields.new(name: 'SEO Keywords', field_type: 'tag_field_type', order_position: 12, validations: {})

    blog.fields.new(name: 'No Index', field_type: 'boolean_field_type', order_position: 13)

    blog.fields.new(name: 'No Follow', field_type: 'boolean_field_type', order_position: 14)

    blog.fields.new(name: 'No Snippet', field_type: 'boolean_field_type', order_position: 15)

    blog.fields.new(name: 'No ODP', field_type: 'boolean_field_type', order_position: 16)

    blog.fields.new(name: 'No Archive', field_type: 'boolean_field_type', order_position: 17)

    blog.fields.new(name: 'No Image Index', field_type: 'boolean_field_type', order_position: 18)

    blog.save
  end
end
