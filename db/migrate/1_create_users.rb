class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :cortex_users, id: :uuid do |t|
      t.string :email, null: false
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :locale, limit: 30, null: false, default: 'en_US'
      t.string :timezone, limit: 30, null: false, default: 'EST'

      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end
