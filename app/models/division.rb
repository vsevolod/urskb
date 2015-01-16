class Division < ActiveRecord::Base
  include AASM
  include OptionAssociations

  has_ancestry
  add_option :report_names

  belongs_to :object_type, class_name: 'Dictionary'

  aasm column: 'state' do
    state :worked, initial: true
    state :closed
  end

end
