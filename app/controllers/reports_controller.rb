class ReportsController < ApplicationController
  
	# GET /reports
  # GET /reports.json
  def index
  	@reports = Report.all
  end

  def download
    @report_details = Report.find(params[:report_id]).report_details

    respond_to do |format|
      format.html
      format.csv { send_data @report_details.to_csv, filename: "report-#{params[:report_id]}-details-#{Time.now}.csv" }
    end
  end


  def create
    processes = Report.get_processes(sort_column, sort_direction, filter_text)

    @report = Report.new(report_date: Time.now, report_user: session[:user_name], description: "testing testing")
    @report.report_details.build(processes)

    respond_to do |format|
      if @report.save
        format.html { redirect_to reports_index_path, notice: 
          "New report Generated on #{@report.report_date}"}
      else format.html { redirect_to reports_index_path, notice: 
          "Failed to generate report"}
      end
    end
  end

  def destroy
    rep = Report.find(params[:report_id])
    rep.destroy
  end

  def show
  end


  def sort_column
    params[:sort] ? params[:sort] : "pid"
  end

  def sort_direction
    params[:direction] ? params[:direction] : "asc"
  end

  def filter_text
    if params[:filter] && params[:filter].chomp == ""
      return nil
    end

    return params[:filter]
  end

  def filter_options

    return {
      "Process ID" => "pid",
      "Process Group ID" => "pgid",
      "Process Name" => "comm",
      "Process Owner" => "user"
    }

  end


end
