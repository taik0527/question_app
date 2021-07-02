class ChangeQuestionsAddDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :questions, :solved, :boolean, default: false, null: false
  end
end
