class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :to_friend_id
      t.integer :topic_id
      t.string :content

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
