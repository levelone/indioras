class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :owner, class_name: 'User'
  belongs_to :assignee, class_name: 'User'

  STATUS = {
    open: 'open',
    in_progress: 'in progress',
    closed: 'closed'
  }.freeze

  TIME_FORMAT = {
    days: 'days',
    hours: 'hours',
    minutes: 'minutes',
  }.freeze

  before_create :set_default_status

  validates :owner, presence: true
  validates :title, presence: true, length: 3..120
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: STATUS.values }
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :open, -> { where(status: STATUS[:open]) }
  scope :closed, -> { where(status: STATUS[:closed]) }
  scope :in_progress, -> { where(status: STATUS[:in_progress]) }
  scope :order_by_status, -> {
    order(
      "CASE
        WHEN status='in progress' THEN 1
        WHEN status='open' THEN 2
        ELSE 3
      END, status;"
    )
  }

  def set_default_status
    status ||= STATUS[:open]
  end

  class << self
    def sum_of_duration
      pluck(:duration).inject { |sum, n| sum + n } || 0
    end
  end
end
