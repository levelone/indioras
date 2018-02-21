class Project < ActiveRecord::Base
  belongs_to :team, required: true
  belongs_to :owner, class_name: 'User'
  has_many :tasks

  validates :name,
    presence: true,
    length: { maximum: 30 }

  def duration_sum
    tasks.map(&:duration).inject { |sum, n| sum + n } || 0
  end
end
