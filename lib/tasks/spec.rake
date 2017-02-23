if Rake::Task.task_defined?('spec:javascript')
  task 'spec:javascript' => 'cortex:assets:webpack:ensure_all_assets_compiled'
end
