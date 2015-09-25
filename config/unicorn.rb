rails_root = ENV['APP_PATH'] || File.expand_path('..', File.dirname(__FILE__))
pid_path   = '/tmp/web_server.pid'
working_directory rails_root
timeout 60

# Environmental specific bindings
if ENV['RAILS_ENV'] == 'development'
  worker_processes 1
  listen "127.0.0.1:#{ENV['PORT'] || 3000}"
  pid_path = "#{rails_root}/tmp/pids/unicorn.pid"
  listen "#{rails_root}/tmp/sockets/unicorn.sock", :backlog => 64
else
  worker_processes 2
  listen "/tmp/web_server.sock", :backlog => 64
  stderr_path "#{rails_root}/log/unicorn.stderr.log"
  stdout_path "#{rails_root}/log/unicorn.stdout.log"
end

# Unicorn kills worker processes that take too long to respond
# Increase the worker timeout if application is being debugged
if ENV['IDE_PROCESS_DISPATCHER']
  timeout 30 * 60 * 60 * 24
end

pid pid_path

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
    GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
    old_pid = "#{pid_path}.oldbin"
    if File.exists?(old_pid) && server.pid != old_pid
        begin
            Process.kill("QUIT", File.read(old_pid).to_i)
        rescue Errno::ENOENT, Errno::ESRCH
            # someone else did our job for us
        end
    end

    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.establish_connection
end
