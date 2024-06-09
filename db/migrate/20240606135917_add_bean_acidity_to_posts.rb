class AddBeanAcidityToPosts < ActiveRecord::Migration[6.1]
  # 豆の酸味
  def change
    add_column :posts, :bean_acidity, :integer
  end
end
