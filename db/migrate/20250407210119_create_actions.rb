class CreateActions < ActiveRecord::Migration[7.0]
  def change
    create_table :actions do |t|
      t.references :transaction, null: false, foreign_key: true
      t.string :action_type, null: false
      t.jsonb :args, default: {}
    end

    add_index :actions, [:transaction_id, :action_type]
  end
end
