module ApplicationHelper
	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column == sort_column ? "current #{sort_direction} " : "current nosort "
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		link_to title, { sort: column, direction: direction, filter_column: filter_column, 
			filter: filter_text }, {:class => css_class}
	end

	def select_options

		options = [
			{ "text" => "Process ID", "value" => "pid" },
      { "text" => "Process Group ID", "value" => "gid"},
      { "text" => "Process Name", "value" => "name"},
      { "text" => "Process Owner", "value" => "user"}
    ]

		select_tag :filter_column,
			options_for_select(options.collect{ |i| [i["text"], i["value"]] })
	end

end

