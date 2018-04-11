class CreateRooms < ActiveRecord::Migration[5.1]
  def self.up
    create_table :rooms do |t|
      t.string :name
      t.string :sessionId
      t.boolean :public

      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end

