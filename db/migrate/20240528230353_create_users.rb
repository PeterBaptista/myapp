class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :cpf

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :cpf, unique: true
  end
end
