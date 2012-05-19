class Point < ActiveRecord::Base
  attr_accessible :comment, :cumulative_value, :value
  
  belongs_to :user
end