if Rake::Task.task_defined?('spec:javascript')
  task 'spec:javascript' => 'webpack:ensure_assets_compiled'
end
