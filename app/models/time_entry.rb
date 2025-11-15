class TimeEntry < ApplicationRecord
  belongs_to :project

  def active?
    end_time.nil?
  end

  def duration
    end_time - start_time if end_time
  end
end
