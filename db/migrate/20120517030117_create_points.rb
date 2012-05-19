class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :value
      t.integer :user_id
      t.string :comment
      t.integer :cumulative_value

      t.timestamps
    end
  end
end
