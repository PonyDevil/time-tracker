class TimeEntriesController < ApplicationController
  def start
    @project = Project.find(params[:project_id])

    if @project.time_entries.where(end_time: nil).exists?
      redirect_to root_path, alert: 'Już trwa sesja!' and return
    end

    @time_entry = @project.time_entries.create!(start_time: Time.current)

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Start!" }
      format.turbo_stream
    end
  end

  def stop
    @project = Project.find(params[:project_id])
    @entry = @project.time_entries.find_by(end_time: nil)

    if @entry
      @entry.update!(end_time: Time.current)
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Zatrzymano!" }
        format.turbo_stream
      end
    else
      redirect_to root_path, alert: 'Brak aktywnej sesji!' and return
    end
  end
end