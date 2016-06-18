class Report < ActiveRecord::Base
	has_many :report_details, dependent: :destroy

	def self.get_processes(sort_column=nil, sort_direction=nil, filter=nil)
		sort_column ||= "pid" # default sort column
		direction = sort_direction == "desc" ? "-" : "+" # default to ascending
		filter ||= nil
		
		sort_condition = "--sort=#{direction}#{sort_column} "
		filter_condition = filter ? "| grep #{filter}" : nil
	
		ps_command = "ps -eo pid,pgid,comm,user:20,pcpu,pmem,args:100,start,etime --no-headers "
		conditions = sort_condition.to_s + filter_condition.to_s
		ps_command += conditions

		process_lines = `#{ps_command}`.split("\n") # array of each process line item
		process_hash = Array.new

		process_lines.each do |line| 
			line_items = line.split(" ") # split each process line to column item and store them as hash objects

			process_hash << {
				process_id: line_items[0],
        process_group_id: line_items[1],
        process_name: line_items[2],
        process_user: line_items[3],
        cpu_consumption: line_items[4],
        mem_consumption: line_items[5],
				full_command: line_items[6],
				start_time: line_items[7],
				elapsed_time: line_items[8]
			}

		end # do

		return process_hash

	end
end
