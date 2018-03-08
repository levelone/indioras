class Team < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :projects
  belongs_to :owner, class_name: 'User'

  TEAM_TYPES = [
    'Accounting',
    'Product Development',
    'Sales/Marketing',
    'IT/Telecommunications',
    'Others'
  ].freeze

  validates :name,
    presence: true,
    length: 4..20

  validates :team_type,
    inclusion: {
      in: TEAM_TYPES,
      message: "%{value} is not a valid team type"
    }
end
