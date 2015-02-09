class PokRules::Pr19 < PokRules

  def self.sql
    dictionary_likes = %w{1221% 1597-р% 1598-р% 1710-р% 1712-р% Бизнес-овердрафт%} 
    dictionary_ids = Dictionary['loan_credit_type'].children.where{name.like_any dictionary_likes}.pluck(:id)
    binding.pry
    credit_type_id = xml_options('credit-type-id', {data: 'numeric', table: 'agreements'})
    AccountsDate
      .joins(account: :agreement)
      .where{(accounts.account_type == 'bad_loan') & (agreements.type == 'Agreement::Loan')}
      .where([<<-SQL, {ids: dictionary_ids}])
        (#{credit_type_id} IN (:ids)) AND
        (agreements.start_date > '2010-30-11')
      SQL
      .select('balance')
  end

end
