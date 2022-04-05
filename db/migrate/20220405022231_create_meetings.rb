class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.references :first_user, null: false
      t.references :second_user, null: false

      t.timestamps
    end
    add_foreign_key :meetings, :users, column: :first_user_id
    add_foreign_key :meetings, :users, column: :second_user_id
  end
end
