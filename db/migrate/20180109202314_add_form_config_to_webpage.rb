class AddFormConfigToWebpage < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :form_configs, :jsonb
  end
end
