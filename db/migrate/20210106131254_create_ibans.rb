class CreateIbans < ActiveRecord::Migration[6.0]
  def change
    create_table :ibans do |t|
      t.string :code
      t.boolean :is_seb
      t.string :bank

      t.timestamps
    end
  end
end
