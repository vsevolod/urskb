class ClientsSegment < ActiveRecord::Base
  belongs_to :client
  belongs_to :segment, class_name: 'Dictionary'
end
