class LinuxProcess
	def self.all
		ps = `ps -eo pid,pgid,comm,user:20,pcpu,pmem`

  	psarr = ps.split("\n")
		all_processes = Array.new

		for a in 1...psarr.length
			proc = Hash.new
			arr = psarr[a].split(" ")

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

end