# Create root tenant and user
tenant_seed = SeedData.cortex_tenant
user_seed = tenant_seed.creator
initial_post_seed = SeedData.initial_post

initial_post = Post.find_by_slug(initial_post_seed.slug) || ArticlePost.new(title: initial_post_seed.title,
                                                                            body: initial_post_seed.body,
                                                                            short_description: initial_post_seed.short_description,
                                                                            slug: initial_post_seed.slug,
                                                                            draft: false,
                                                                            published_at: Time.now,
                                                                            job_phase: initial_post_seed.job_phase,
                                                                            display: initial_post_seed.display,
                                                                            copyright_owner: initial_post_seed.copyright_owner)

existing_tenant = Tenant.find_by_name(tenant_seed.name)

if existing_tenant
  initial_post.user = existing_tenant.owner
else
  cortex_tenant = Tenant.new(name: tenant_seed.name)

  cortex_tenant.owner = User.new(email: user_seed.email,
                                 firstname: user_seed.firstname,
                                 lastname: user_seed.lastname,
                                 password: user_seed.password,
                                 password_confirmation: user_seed.password,
                                 tenant: cortex_tenant,
                                 admin: true)

  cortex_tenant.save!

  initial_post.user = cortex_tenant.owner
end

initial_post.save!
