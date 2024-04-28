class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :application_token, null: false
      t.integer :chat_number, null: false
      t.integer :message_number, null: false
      t.text :body, null: false
      t.timestamps
    end
    # add_foreign_key :messages, :chats
    add_index :messages, [:application_token, :chat_number]
  end
end
