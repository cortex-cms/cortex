class MakeWebpageUrlCaseInsensitive < ActiveRecord::Migration[5.0]
  def change
    enable_extension :citext
    change_column :webpages, :url, :citext
  end
end
