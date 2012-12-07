class AddReportEmailFieldsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :email_order_report_to, :string
    add_column :accounts, :email_daily_report_to, :string
    add_column :accounts, :email_weekly_report_to, :string
    add_column :accounts, :email_monthly_report_to, :string
  end
end
