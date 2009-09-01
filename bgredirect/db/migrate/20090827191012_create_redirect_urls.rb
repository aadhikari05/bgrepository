class CreateRedirectUrls < ActiveRecord::Migration
  def self.up
    create_table :redirect_urls do |t|
      t.text :redirect_url
      t.string :keyword1
      t.string :keyword2
      t.string :keyword3
      t.string :keyword4
      t.string :keyword5

      t.timestamps
    end
  end

  def self.down
    drop_table :redirect_urls
  end
end
