class Account < ActiveRecord::Base
  include States

  STORE_OPTIONS = {
    statement_id: 'Выписка по счету',
    vsb_id: 'ID VSB',
    orgstruct_code: 'Код оргструктур',
    note: 'Примечания',
    consolidate_account: 'Сводный счет',
    filial: 'Филиал'
  }

  store :options, accessors: STORE_OPTIONS.keys

  aasm column: 'account_type' do
    state :term_loan           # Срочная ссуда (53, 41)
    state :bad_loan            # Просроченная ссуда (54)
  end
  
  belongs_to :name, class_name: 'Dictionary'
  belongs_to :agreement
  belongs_to :client
  belongs_to :account_client, class_name: 'Client'

  validates :number, uniqueness: {scope: [:old_id], case_sensitive: false}

  validate :number_or_old_id

  # Поиск счета по old_id или number, Если не найдено - инициализируем
  def self.f(options)
    self.where(options.compact).first_or_initialize
  end

  private

    def number_or_old_id
      if old_id.blank? && number.blank?
        errors[:base] << "Должен быть Номер счета или Идентификационный номер"
      end
    end
end
