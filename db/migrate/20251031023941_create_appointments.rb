class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.date :data
      t.string :nome
      t.string :telefone
      t.string :endereco

      t.timestamps
    end
  end
end
