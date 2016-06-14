json.array!(@processes) do |process|
  json.extract! process, :pid, :gid, :name, :user, :cpu, :mem
  json.url dashboard_url(process, format: :json)
end
