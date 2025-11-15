class Project < ApplicationRecord
    has_many :time_entries, dependent: :destroy

    def total_time_in_seconds
        time_entries.where.not(end_time:nil).sum { |e| e.end_time - e.start_time}
    end

    def total_time_formatted
        seconds = total_time_in_seconds
        hours = seconds / 3600
        minutes = (seconds % 3600) / 60
        "#{hours}:#{minutes.to_s.rjust(2, '0')}h"
    end
end
