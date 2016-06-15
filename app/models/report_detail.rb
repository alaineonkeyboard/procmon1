class ReportDetail < ActiveRecord::Base
  belongs_to :report

	def self.to_csv (options = {})
  	CSV.generate(options) do |csv|
    csv << column_names
    all.each do |detail|
      csv << detail.attributes.values_at(*column_names)
    end
  	end
  end
end
