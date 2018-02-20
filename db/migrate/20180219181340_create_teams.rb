class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :owner_id
      t.string :name
      t.string :description
    end
  end
end
