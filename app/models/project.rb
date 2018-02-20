class Project < ActiveRecord::Base
  belongs_to :team, required: true
  belongs_to :owner, class_name: 'User'

  validates :name,
    presence: true,
    length: { maximum: 30 }
end
