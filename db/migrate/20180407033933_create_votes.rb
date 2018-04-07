class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.string :user_id
      t.integer :value

      t.timestamps
    end
  end
end
