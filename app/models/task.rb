class Task < ActiveRecord::Base
  belongs_to :project

  validates :title,
    presence: true,
    length: 3..30

  STATUS = {
    open: 'open',
    in_progress: 'in progress',
    closed: 'closed'
  }
end
