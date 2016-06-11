class DashboardController < ApplicationController
  def index
  	@processes = get_processes
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
  def get_processes
  	LinuxProcess.all
  end

end
