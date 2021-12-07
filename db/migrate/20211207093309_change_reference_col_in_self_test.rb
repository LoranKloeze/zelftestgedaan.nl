class ChangeReferenceColInSelfTest < ActiveRecord::Migration[6.1]
  def change
    rename_column :self_tests, :ip_reference, :reference
  end
end
