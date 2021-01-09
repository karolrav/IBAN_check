class CreateIbans < ActiveRecord::Migration[6.0]
  def change
    create_table :ibans do |t|
      t.string :code
      t.string :is_seb
      t.boolean :bank

      t.timestamps
    end
  end
end
