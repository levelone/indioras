class Team < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :projects
  belongs_to :owner, class_name: 'User'

  validates :name,
    presence: true,
    length: 4..20
end
