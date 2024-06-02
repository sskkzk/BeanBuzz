class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      # 豆の産地
      t.string :been_origin
      # 豆の焙煎度
      t.string :been_roast
      # 豆の味わい
      t.string :been_taste
      # 抽出方法
      t.string :been_extraction
      # タイトル
      t.string :been_title
      # 本文
      t.text :title
      # 作成更新日時
      t.timestamps
      # 画像はアクティブストレージ利用
    end
  end
end
