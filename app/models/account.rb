class Account < ActiveRecord::Base
  include AASM

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
    # /^(20311\d{8}0[1256]|20312|40308|4(4[^0]|5[12346])(?!15)|4(6\d|7[0123])(?!08)|40109\d{8}[^456]|40111|47402\d{8}(?!01|03)|47701|478(?!04|01\d{8}02)|51[235679](?!08|09|10)|60315|50408)/
    state :bad_loan            # Просроченная ссуда (54)
    # /^(20317\d{8}(?!03|04)|20318|40310|458(?!15|17|18)|47402\d{8}0[24]|51[235679]0[89]|20319\d{8}(?!03|04)|20320|40311|40109{8}[456]|459(?!15|17|18)|47402\d{8}06)/
  end
  
  belongs_to :name, class_name: 'Dictionary'
  belongs_to :agreement

  validates :number, presence: {if: 'old_id.blank?'}, uniqueness: {if: 'number.present?'}
  validates :old_id, presence: {if: 'number.blank?'}, uniqueness: {if: 'old_id.present?'}

  # Поиск счета по old_id или number, Если не найдено - инициализируем
  def self.f(options)
    self.where(options.compact).first_or_initialize
  end
end
