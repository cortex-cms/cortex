module ContentItemTagUpdater
  def self.update_tags(content_item, tag_data_array)
    tag_list_name = "#{tag_data_array[0].downcase.gsub(' ', '_').singularize}_list="
    tag_array = tag_data_array[1]

    content_item.send(tag_list_name, tag_array)
  end
end
