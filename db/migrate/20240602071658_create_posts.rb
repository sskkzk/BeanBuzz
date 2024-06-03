class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      # 豆の産地
      t.string :bean_origin
      # 豆の焙煎度
      t.string :bean_roast
      # 豆の味わい
      t.string :bean_taste
      # 抽出方法
      t.string :bean_extraction
      # タイトル
      t.string :bean_title
      # 本文
      t.text :bean_body
      # 作成更新日時
      t.timestamps
      # 画像はアクティブストレージ利用
    end
  end
end
