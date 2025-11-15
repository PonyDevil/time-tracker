class Project < ApplicationRecord
    has_many :time_entries, dependent: :destroy

    validates :name, presence: true, length: { maximum: 100 }

    def total_time_in_seconds
        time_entries.where.not(end_time:nil).sum { |e| e.end_time - e.start_time}
    end

    def total_time_formatted
        total_seconds = total_time_in_seconds.to_i
        hours = total_seconds / 3600
        minutes = (total_seconds % 3600) / 60
        "#{hours}:#{minutes.to_s.rjust(2, '0')}h"
    end
end
