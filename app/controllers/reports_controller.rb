class ReportsController < ApplicationController
  
	# GET /reports
  # GET /reports.json
  def index
  	@reports = Report.all
  end

  def create
  	ps = `ps -eo pid,pgid,comm,user:20,pcpu,pmem`

    psarr = ps.split("\n")
    all_processes = Array.new

    for a in 1...psarr.length
      proc = Hash.new
      arr = psarr[a].split(" ")

      proc = {
        process_id: arr[0],
        process_group_id: arr[1],
        process_name: arr[2],
        process_user: arr[3],
        cpu_consumption: arr[4],
        mem_consumption: arr[5]
      }
      all_processes << proc
    end

    @report = Report.new(report_date: Time.now, report_user: "alaine", description: "testing testing")
    @report.report_details.build(all_processes)

    respond_to do |format|
      if @report.save
        format.html { redirect_to reports_index_path, notice: 
          "Report Generated on #{@report.report_date}"}
      else format.html { redirect_to reports_index_path, notice: 
          "Failed to generate report"}
      end
    end
  end

  def destroy
    rep = Report.find(5)
    rep.destroy
  end

  def show
  end
end
