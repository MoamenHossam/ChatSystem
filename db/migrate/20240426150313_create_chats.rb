class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.string :application_token, null: false
      t.string :name, null: false
      t.integer :number, null: false
      t.integer :messages_count, default: 0

      t.timestamps
    end
    add_foreign_key :chats, :applications, column: :application_token, primary_key: :token
    add_index :chats, :application_token
    add_index :chats, [:application_token, :number], unique: true
  end
end
