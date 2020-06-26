class CreatePortfolios < ActiveRecord::Migration[6.0]
  def change
    create_table :portfolios do |t|
      t.string :name
      t.text :description
      t.string :status, default: "active"

      t.timestamps
    end
  end
end
