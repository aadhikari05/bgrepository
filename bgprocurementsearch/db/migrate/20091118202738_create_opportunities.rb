class CreateOpportunities < ActiveRecord::Migration
  def self.up
    create_table :opportunities do |t|
      t.string :sol_type, :limit => 100,   :null => false
      t.date :sol_date
      t.string :agency, :limit => 500,  :null => false
      t.string :agency_office, :limit => 500
      t.string :agency_location, :limit => 500
      t.string :agency_zip, :limit => 10
      t.string :agency_office_address, :limit => 1000
      t.string :classcode, :limit => 5,    :null => false
      t.string :naics, :limit => 1000
      t.string :subject, :null => false
      t.string :sol_nbr, :limit => 128,  :null => false
      t.string :prime_sol_nbr, :limit => 128
      t.datetime :resp_date
      t.date :archive_date
      t.string :archive_policy
      t.text :sol_desc, :limit => 65535
      t.string :link_url
      t.string :link_desc
      t.text :contact, :limit => 65535, :null => false
      t.string :contact_email, :limit => 128
      t.string :contact_email_desc
      t.string :setaside, :limit => 1000
      t.string :pop_address, :limit => 1000
      t.string :pop_zip, :limit => 10
      t.string :pop_country, :limit => 32
      t.boolean :active_ind
      t.boolean :recovery_ind
      t.string :pop_state, :limit =>1000
      
      t.timestamps
    end
  end

  def self.down
    drop_table :opportunities
  end
end
