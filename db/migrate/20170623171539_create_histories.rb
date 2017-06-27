class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :amount
      t.references :lender
      t.references :borrower

      t.timestamps null: false
    end
  end
end
