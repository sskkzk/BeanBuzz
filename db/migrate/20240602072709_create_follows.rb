class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      
      # フォロワーID
      t.integer :follower_id
      
      # フォロイーID
      t.integer :followee_id
      
      t.timestamps
    end
  end
end
