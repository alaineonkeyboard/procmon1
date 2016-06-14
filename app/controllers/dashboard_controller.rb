class DashboardController < ApplicationController
helper_method :sort_column, :sort_direction

  def index
  	@processes = LinuxProcess.order(sort_column, sort_direction)
  end

  def kill
  	pid = params[:pid]
  	LinuxProcess.kill(pid)
  	@processes = get_processes

  	respond_to do |format|
  		format.html { redirect_to '', 
  			notice: "Process ID #{pid} was successfully killed." }
  	end
  end

  private

  def sort_column
    params[:sort] ? params[:sort] : "pid"
  end

  def sort_direction
    params[:direction] ? params[:direction] : "asc"
  end


end
