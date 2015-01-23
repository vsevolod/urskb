class AccountsDate < ActiveRecord::Base
  belongs_to :account
  belongs_to :division

  STORE_OPTIONS = {
    rate: 'Курс',
    removal_date_by_account_id: 'Дата выноса по ID счета',
    removal_date: 'Дата выноса на просрочку',
    previous_maturity_date: 'Предыдущая дата полного погашения просрочки'
  }

  store :options, accessors: STORE_OPTIONS.keys

end
