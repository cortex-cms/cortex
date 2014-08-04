app_root = ENV['APP_PATH'] || Rails.root

worker_processes 2

working_directory app_root

listen "/tmp/web_server.sock", :backlog => 64

timeout 30

pid '/tmp/web_server.pid'

# Bind to a port for quick debugging
if Rails.env.development?
  listen '127.0.0.1:3000'
end

stderr_path "#{app_root}/log/unicorn.stderr.log"
stdout_path "#{app_root}/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
    GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
    old_pid = '/tmp/web_server.pid.oldbin'
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
