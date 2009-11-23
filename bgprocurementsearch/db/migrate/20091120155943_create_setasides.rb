class CreateSetasides < ActiveRecord::Migration
  def self.up
    create_table :setasides do |t|
      t.string :s_type
      t.string :s_value

      t.timestamps
    end
  end

  def self.down
    drop_table :setasides
  end
end
