if Rake::Task.task_defined?('spec:javascript')
  Rake::Task['spec:javascript']
    .enhance([:environment, 'webpack:ensure_assets_compiled'])
end
