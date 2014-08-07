class ApplicationsWriteField < ActiveRecord::Migration
  def change
    change_table :applications do |t|
      t.boolean :write, default: false
    end
  end
end
