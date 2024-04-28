class CreateMessageNextIds < ActiveRecord::Migration[7.1]
  def change
    create_table :message_next_ids do |t|
      t.string :token, null: false
      t.integer :chat_number, null: false
      t.integer :next_id, default: 1
      t.integer :lock_version, default: 0
      t.timestamps
    end
  end
end
