class CreatePublishStates < ActiveRecord::Migration
  def change
    create_table :publish_states do |t|
      t.references :content_item
      t.string     :state

      t.timestamps null: false
    end
  end
end
