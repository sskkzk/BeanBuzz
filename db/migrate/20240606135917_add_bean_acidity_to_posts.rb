class AddBeanAcidityToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :bean_acidity, :string
  end
end
