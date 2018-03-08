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

  DURATION_TYPE = {
    day: (24*60*60),
    hour: (60*60),
    minute: 60
  }.freeze

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

  def get_duration_value
    return (duration / DURATION_TYPE[:day]) if divisible_per_day?
    return (duration / DURATION_TYPE[:hour]) if divisible_per_hour?
    duration / DURATION_TYPE[:minute]
  end

  def get_duration_type
    return 'days' if divisible_per_day?
    return 'hours' if divisible_per_hour?
    'minutes'
  end

  def divisible_per_day?
    (duration % DURATION_TYPE[:day]) == 0
  end

  def divisible_per_hour?
    (duration % DURATION_TYPE[:hour]) == 0
  end

  def divisible_per_minute?
    (duration % DURATION_TYPE[:minute]) == 0
  end

  class << self
    def sum_of_duration
      pluck(:duration).inject { |sum, n| sum + n } || 0
    end
  end
end
