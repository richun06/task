class AddColumnToLabels < ActiveRecord::Migration[6.1]
  def change
    add_column :labels, :name, :string
  end
end
