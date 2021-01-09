class ChangeVariables < ActiveRecord::Migration[6.0]
  def change
    change_column :ibans, :is_seb, :string
    change_column :ibans, :bank, :boolean
  end
end
