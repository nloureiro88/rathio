class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :scope
      t.string :industry
      t.string :stage
      t.string :country
      t.string :status, default: "active"

      t.timestamps
    end
  end
end
