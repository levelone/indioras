module ApplicationHelper
  def transform_seconds_into_presentable_time(seconds)
    minutes, _ = seconds.divmod(60)
    hours, minutes = minutes.divmod(60)
    days, hours = hours.divmod(24)
    time_in = { days: days, hours: hours, minutes: minutes }
    presentable_time = time_in.map { |k, v| "#{v} #{k}" if v > 0 }.compact
    presentable_time.join(', ')
  end
end
