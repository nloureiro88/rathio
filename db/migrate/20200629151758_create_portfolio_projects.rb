class CreatePortfolioProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :portfolio_projects do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.integer :position
      t.string :status, default: "active"

      t.timestamps
    end
  end
end
