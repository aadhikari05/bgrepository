class CreateParsedFiles < ActiveRecord::Migration
  def self.up
    create_table :parsed_files do |t|
      t.string :file_name, :limit => 100
      t.string :details

      t.timestamps
    end
  end

  def self.down
    drop_table :parsed_files
  end
end
