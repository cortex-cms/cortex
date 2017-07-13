class AddCaroteneRefToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :carotene, type: :uuid, foreign_key: true, index: true
  end
end
