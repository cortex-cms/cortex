def cmd(c)
  system c
end

namespace :tddium do
  desc 'post_build_hook'
  task :post_build_hook do
    return unless ENV['TDDIUM_MODE'] == 'ci'
    return unless ENV['TDDIUM_BUILD_STATUS'] == 'passed'

    current_branch = `git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3-`.strip

    abort 'invalid current branch' unless current_branch

    case
      when current_branch == 'master'
        redeployment_hook_url = 'https://hooks.cloud66.com/stacks/redeploy/78f9fff824b52e6771109239804d0682/05486afef355596820dff6ec8263dbd9'
      else
        abort "invalid current branch: #{current_branch}"
    end

    puts "Triggering Cloud66 build for branch: #{current_branch}..."
    cmd "curl -X POST -d '' #{redeployment_hook_url}" or abort "could not push deployment for Cloud66 on branch #{current_branch}"
  end
end
