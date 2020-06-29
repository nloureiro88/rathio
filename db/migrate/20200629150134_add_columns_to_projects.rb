class AddColumnsToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :start_date, :time
    add_column :projects, :end_date, :time
    add_column :projects, :inflation_rate, :float, default: 0.02
    add_column :projects, :income_tax_rate, :float, default: 0.25
    add_column :projects, :valuation_factor, :float, default: 5.00
  end
end
