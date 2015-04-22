require 'csv'

class BulkCreateUsersJob < ActiveJob::Base
  queue_as :default

  def perform(bulk_job)
    @bulk_job = bulk_job
    metadata_file = Paperclip.io_adapters.for(@bulk_job.metadata).read

    CSV.parse(metadata_file, { :headers => true, :col_sep => ',' }) do |row|
      row_hash = row.to_hash
      begin
        user_attributes = generate_user_attributes(row_hash)
      rescue Exception => e
        write_status(e.message)
        next
      end

      user = ::User.find_by_id(row_hash['ID'])
      if user
        begin
          user.update!(user_attributes)
          write_status("Processed '#{row_hash['Email']}'. Updated existing User with ID #{row_hash['ID']}.")
        rescue Exception => e
          write_status("Error processing '#{row_hash['Email']}'. Failed to update existing User with ID #{row_hash['ID']}. Exception details: #{e.message}")
        end
      else
        begin
          user = ::User.create!(user_attributes)
          write_status("Processed '#{row_hash['Email']}'. Created new User with ID #{user.id}.")
        rescue Exception => e
          write_status("Error processing '#{row_hash['Email']}'. Failed to create User. Exception details: #{e.message}")
        end
      end
    end
  end

  private

  def generate_user_attributes(row_hash)
    user_attributes = {
      email: row_hash['Email'],
      firstname: row_hash['First Name'],
      lastname: row_hash['Last Name'],
      admin: row_hash['Is Admin? (true or false)'],
      tenant_id: row_hash['Tenant ID'],
      password: 'welcome1',
      password_confirmation: 'welcome1'
    }

    user_attributes
  end

  def write_status(message)
    @bulk_job.status = message
    @bulk_job.log ||= []
    @bulk_job.log << message

    @bulk_job.save!
  end
end
