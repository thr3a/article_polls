class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :group_id, null: false
      t.string :user_id, limit: 32, null: false
      t.integer :value, null: false
      t.string :url, null: false
      t.string :url_h, limit: 12, null: false
      t.string :article_id
      t.timestamps
    end
  end
end
