class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.text :hash, null: false
      t.text :sender, null: false
      t.text :receiver, null: false
      t.references :block, null: false, foreign_key: true
      t.datetime :created_at, null: false
    end
    add_index :transactions, :hash, unique: true # Ensure hash is unique
  end
end
