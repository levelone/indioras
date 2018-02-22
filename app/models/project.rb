class Project < ActiveRecord::Base
  belongs_to :team, required: true
  belongs_to :owner, class_name: 'User'
  has_many :tasks

  validates :name,
    presence: true,
    length: { maximum: 30 }

  def percentage_of_progress
    time_remaining = tasks.open.sum_of_duration.to_f
    time_completed = tasks.closed.sum_of_duration.to_f
    estimated_time = time_remaining + time_completed
    (time_completed / estimated_time * 100).to_f
  end
end
