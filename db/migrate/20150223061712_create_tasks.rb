class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string   :title,        null: false
      t.text     :body,         null: false
      t.datetime :expiration
      t.datetime :completed_on
      t.integer  :position

      t.belongs_to :user, index: true

      t.timestamps
    end

    add_index :tasks, :title
    add_index :tasks, :position
  end
end
