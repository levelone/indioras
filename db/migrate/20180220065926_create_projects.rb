class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :team_id
      t.integer :owner_id
      t.string :name
      t.string :description
    end
  end
end
