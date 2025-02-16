class AddSlugToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :slug, :string
    add_index :products, :slug, unique: true
  end
end
