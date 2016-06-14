class LinuxProcess
	def self.all
		ps = `ps -eo pid,pgid,comm,user:20,pcpu,pmem --no-headers`

  	psarray = ps.split("\n")
		all_processes = Array.new

		for a in 0...psarray.length
			proc = Hash.new
			arr = psarray[a].split(" ")

			proc = {
				pid: arr[0],
				gid: arr[1],
				name: arr[2],
				user: arr[3],
				cpu: arr[4],
				mem: arr[5]
			}
			all_processes << proc
		end

		all_processes
	end

	def self.kill(pid)
		`kill #{pid}`
	end

	def self.order(sort_column, sort_direction)

		direction = sort_direction == "asc" ? "+" : "-"
		ps = `ps -eo pid,pgid,comm,user:20,pcpu,pmem --no-headers --sort=#{direction}#{sort_column}`

  	psarray = ps.split("\n")
		all_processes = Array.new

		for a in 0...psarray.length
			proc = Hash.new
			arr = psarray[a].split(" ")

			proc = {
				pid: arr[0],
				gid: arr[1],
				name: arr[2],
				user: arr[3],
				cpu: arr[4],
				mem: arr[5]
			}
			all_processes << proc
		end

		all_processes
	end

	def self.filter
	end


end