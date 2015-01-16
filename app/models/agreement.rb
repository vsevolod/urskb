class Agreement < ActiveRecord::Base

  include AASM
  include AgreementAssociations
  has_ancestry

  #SUB_TYPES = [
  #  Agreement::Loan               # Кредитный договор
  #  Agreement::Deposit,           # Депозит
  #  Agreement::Cash,              # Расчетно-кассовое обслуживание РКО
  #  Agreement::Salary             # Зарплатный
  #]

  aasm column: 'state' do
    state :open                  # Открыт
    state :reserved              # Зарезервирован дистанционно
    state :marked_for_open       # Помечен к открытию
    state :worked, initial: true # Работает
    state :closed                # Закрыт
  end

  belongs_to :client
  belongs_to :division
  belongs_to :currency, class_name: 'Dictionary'
  has_many :accounts, dependent: :destroy

end
