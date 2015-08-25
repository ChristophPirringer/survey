class Question < ActiveRecord::Base
  belongs_to(:survey)

  # after do
  #   ActiveRecord::Base.connection.close
  # end
end
