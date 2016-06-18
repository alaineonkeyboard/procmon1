class CreateReportDetails < ActiveRecord::Migration
  def change
    create_table :report_details do |t|
      t.belongs_to :report, index: true
      t.string :process_id
      t.string :process_group_id
      t.string :process_name
      t.string :process_user
      t.string :cpu_consumption
      t.string :mem_consumption
      t.string :full_command
      t.string :start_time
      t.string :elapsed_time
      t.timestamps
    end
  end
end
