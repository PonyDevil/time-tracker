class TimeEntriesController < ApplicationController
  def start
    @project = Project.find(params[:project_id])
    
    if @project.time_entries.where(end_time: nil).exists?
      redirect_to root_path, alert: 'Już trwa sesja!'
      return
    end

    @project.time_entries.create!(start_time: Time.current)
    redirect_to root_path, notice: "Start: #{@project.name}"
  end

  def stop
    @project = Project.find(params[:project_id])
    @entry = @project.time_entries.find_by(end_time: nil)

    if @entry
      @entry.update!(end_time: Time.current)
      redirect_to root_path, notice: "Stop! (+#{format_duration(@entry.duration)})"
    else
      redirect_to root_path, alert: 'Brak aktywnej sesji!'
    end
  end

  private

  def format_duration(seconds)
    return "0:00" unless seconds
    minutes = (seconds / 60).to_i
    secs = (seconds % 60).to_i
    "#{minutes}:#{secs.to_s.rjust(2, '0')}"
  end
end
