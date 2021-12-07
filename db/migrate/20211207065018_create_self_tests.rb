class CreateSelfTests < ActiveRecord::Migration[6.1]
  def change
    create_table :self_tests do |t|
      t.date :done_at
      t.boolean :is_positive
      t.string :ip_reference

      t.timestamps
    end
    add_index :self_tests, :ip_reference
    add_index :self_tests, :done_at
    add_index :self_tests, :is_positive
  end
end
