json.array!(@processes) do |process|
  json.extract! process, :pid, :pgid, :command, :user, :cpu, :mem
  json.url dashboard_url(process, format: :json)
end
