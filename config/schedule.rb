# Run the job 1 minute after midnight to publish any scheduled items
every :day, at: '10:20 am' do
  runner "PublishStateManager.publish_valid_items"
end
