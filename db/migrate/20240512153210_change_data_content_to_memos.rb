class ChangeDataContentToMemos < ActiveRecord::Migration[6.1]
  def change
      change_column :memos, :content, :text
  end
end
