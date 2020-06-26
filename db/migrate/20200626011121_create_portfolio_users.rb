class CreatePortfolioUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :portfolio_users do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :inviter
      t.string :role
      t.string :status, default: "active"

      t.timestamps
    end
  end
end
