class ChangeCloumnsNotnullAddTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :title, false
    change_column_null :tasks, :content, false
  end
end
