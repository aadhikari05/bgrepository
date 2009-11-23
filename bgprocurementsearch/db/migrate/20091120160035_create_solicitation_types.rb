class CreateSolicitationTypes < ActiveRecord::Migration
  def self.up
    create_table :solicitation_types do |t|
      t.string :s_type
      t.string :s_value

      t.timestamps
    end
  end

  def self.down
    drop_table :solicitation_types
  end
end
