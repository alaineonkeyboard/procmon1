class Dashboard

	def self.get_processes(sort_column=nil, sort_direction=nil, filter=nil)
		sort_column ||= "pid" # default sort column
		direction = sort_direction == "desc" ? "-" : "+" # default to ascending
		filter ||= nil
		
		sort_condition = "--sort=#{direction}#{sort_column} "
		filter_condition = filter ? "| grep #{filter}" : nil
	
		ps_command = "ps -eo pid,pgid,comm,user:20,pcpu,pmem,args,start,etime --no-headers "
		conditions = sort_condition.to_s + filter_condition.to_s
		ps_command += conditions

		process_lines = `#{ps_command}`.split("\n") # array of each process line item
		process_hash = Array.new

		process_lines.each do |line| 
			line_items = line.split(" ") # split each process line to column item and store them as hash objects

			process_hash << {
				pid: line_items[0],
				gid: line_items[1],
				name: line_items[2],
				user: line_items[3],
				cpu: line_items[4],
				mem: line_items[5],
				fullname: line_items[6],
				start: line_items[7],
				etime: line_items[8]
			}

		end # do

		return process_hash

	end

	def self.kill(pid)
		`kill #{pid}`
	end

end