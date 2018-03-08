class AddDefaultValueToTaskColumnStatusAndDuration < ActiveRecord::Migration
  def up
    change_column :tasks, :status, :string, default: 'open'
    change_column :tasks, :duration, :integer, default: 0
  end

  def down
    change_column :tasks, :duration, :string, nil
    change_column :tasks, :status, :integer, nil
  end
end
