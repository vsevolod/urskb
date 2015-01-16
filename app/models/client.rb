class Client < ActiveRecord::Base

  STORE_OPTIONS = {
    okpo: 'ОКПО',
    ogrn: 'ОГРН'
  }

  store :options, accessors: STORE_OPTIONS.keys

  belongs_to :low_form, class_name: 'Dictionary'
  has_many :clients_segments
  has_many :segments, through: :clients_segments

end
