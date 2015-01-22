#SUB_TYPES = [
#  Agreement::Loan               # Кредитный договор
#  Agreement::Deposit,           # Депозит
#  Agreement::Cash,              # Расчетно-кассовое обслуживание РКО
#  Agreement::Salary             # Зарплатный
#]
class Agreement < ActiveRecord::Base

  include States
  include AgreementAssociations
  has_ancestry

  belongs_to :client
  belongs_to :division
  belongs_to :currency, class_name: 'Dictionary'
  has_many :accounts, dependent: :destroy

end
