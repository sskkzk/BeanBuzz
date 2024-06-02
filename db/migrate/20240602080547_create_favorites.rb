class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      # 副キーのみ
      t.timestamps
    end
  end
end
