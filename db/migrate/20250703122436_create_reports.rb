class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.date :worked_on

      t.timestamps
    end
  end
end
