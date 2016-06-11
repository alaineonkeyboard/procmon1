class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.datetime :report_date
      t.string :report_user
      t.text :description

      t.timestamps
    end
  end
end
