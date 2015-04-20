require 'csv'
require 'zip'

class BulkCreateMediaJob < ActiveJob::Base
  queue_as :default

  def perform(bulk_job, current_user)
    @bulk_job = bulk_job
    metadata_file = Paperclip.io_adapters.for(@bulk_job.metadata).read
    assets_file = Paperclip.io_adapters.for(@bulk_job.assets).read

    Zip::File.open_buffer(assets_file) do |zip_file|
      write_status('Opened Assets ZIP')

      CSV.parse(metadata_file, { :headers => true, :col_sep => ',' }) do |row|
        row_hash = row.to_hash
        begin
          media_attributes = generate_media_attributes(zip_file, row_hash)
        rescue Exception => e
          write_status(e.message)
          next
        end

        media = ::Media.find_by_id(row_hash['ID'])
        if media
          begin
            media.update!(media_attributes)
            write_status("Processed '#{row_hash['Display Name']}'. Updated existing Media with ID #{row_hash['ID']}.")
          rescue Exception => e
            write_status("Error processing '#{row_hash['Display Name']}'. Failed to update existing Media with ID #{row_hash['ID']}. Exception details: #{e.message}")
          end
        else
          begin
            media = ::Media.new(media_attributes)
            media.user = current_user
            media.save!
            write_status("Processed '#{row_hash['Display Name']}'. Created new Media with ID #{media.id}.")
          rescue Exception => e
            write_status("Error processing '#{row_hash['Display Name']}'. Failed to create Media. Exception details: #{e.message}")
          end
        end
      end
    end
  end

  private

  def generate_media_attributes(zip_file, row_hash)
    media_attributes = {
      name: row_hash['Display Name'],
      description: row_hash['Description'],
      deactive_at: row_hash['Expiration'],
      tag_list: row_hash['Tags'],
      type: row_hash['Type (Media, Youtube)']
    }

    if row_hash['Type (Media, Youtube)'] == 'Media'
      begin
        media_attachment = zip_file.get_entry(row_hash['Filename'])
      rescue
        raise "Error finding or processing '#{row_hash['Filename']}' in Assets ZIP. Exception details: #{$!}"
      end
      media_attributes[:attachment] = StringIO.new(media_attachment.get_input_stream.read)
      media_attributes[:attachment_file_name] = row_hash['Filename']
    else
      media_attributes[:video_id] = row_hash['Youtube ID']
    end

    media_attributes
  end

  def write_status(message)
    @bulk_job.status = message
    @bulk_job.log ||= []
    @bulk_job.log << message

    @bulk_job.save!
  end
end
