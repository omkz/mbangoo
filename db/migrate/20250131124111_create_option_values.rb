class CreateOptionValues < ActiveRecord::Migration[7.2]
  def change
    create_table :option_values do |t|
      t.references :option_type, null: false, foreign_key: true
      t.string :value, null: false 

      t.timestamps
    end
  end
end
