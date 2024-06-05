class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      # 副キー
      t.integer :user_id
      t.integer :posts_id
      
      t.timestamps
    end
  end
end
