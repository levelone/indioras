class Team < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name,
    presence: true,
    length: 4..20
end
