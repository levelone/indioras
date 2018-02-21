class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.string :title
      t.string :description
      t.string :status
      t.integer :duration
      t.date :start_date
      t.date :end_date
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
