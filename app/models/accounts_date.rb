class AccountsDate < ActiveRecord::Base
  belongs_to :account
  belongs_to :division
end
