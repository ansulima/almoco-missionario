class RemoveEnderecoFromAppointments < ActiveRecord::Migration[8.0]
  def change
    remove_column :appointments, :endereco, :string
  end
end
