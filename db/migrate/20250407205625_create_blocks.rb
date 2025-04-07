class CreateBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :blocks do |t|
      t.integer :height, null: false
      t.string :block_hash, null: false
      t.datetime :created_at, null: false
    end

    add_index :blocks, :height, unique: true # Ensure height is unique
    # This index is not strictly necessary, but it can help with lookups by block_hash
    add_index :blocks, :block_hash, unique: true # Ensure block_hash is unique
    # Add a unique index on the combination of height and block_hash
  end
end
