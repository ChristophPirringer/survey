class CreateScaledAnswers < ActiveRecord::Migration
  def change
    add_column(:questions, :value, :int)
  end
end
