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

    redeployment_targets = Array.new
    # Move branch/url config into yml in the future
    case
      when current_branch == 'master'
        redeployment_targets << { :environment => 'staging', :hook_url => 'https://hooks.cloud66.com/stacks/redeploy/78f9fff824b52e6771109239804d0682/b17b5ba29fa940431bfb3012b76edfa6' }
        redeployment_targets << { :environment => 'production', :hook_url => 'https://hooks.cloud66.com/stacks/redeploy/78f9fff824b52e6771109239804d0682/05486afef355596820dff6ec8263dbd9' }
      else
        abort "invalid current branch: #{current_branch}"
    end

    puts "Triggering Cloud66 build(s) for branch: #{current_branch}..."

    redeployment_targets.each { |target|
      puts "Triggering Cloud66 build for environment: #{target[:environment]}"
      cmd "curl -X POST -d '' #{target[:hook_url]}" or abort "could not push deployment for Cloud66 on branch #{current_branch} for environment #{target[:environment]}"
    }
  end
end
