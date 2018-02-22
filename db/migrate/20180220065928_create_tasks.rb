class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.integer :owner_id
      t.integer :assignee_id
      t.string :title
      t.string :description
      t.string :status, null: false
      t.integer :duration
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
