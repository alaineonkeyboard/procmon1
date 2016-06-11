class ReportsController < ApplicationController
  
	# GET /reports
  # GET /reports.json
  def index
  	@reports = Report.all
  end

  def create
  	
  end

  def destroy
  end

  def show
  end
end
