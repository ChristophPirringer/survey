class Survey < ActiveRecord::Base
  has_many(:questions)
  # after do
  #   ActiveRecord::Base.connection.close
  # end
end
