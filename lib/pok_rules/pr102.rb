class PokRules::Pr102 < PokRules

  def self.sql
    dictionary_likes = %w{1221% 1597-р% 1598-р% 1710-р% 1712-р% Бизнес-овердрафт%} 
    dictionary_ids = Dictionary['loan_credit_type'].children.where{name.like_any dictionary_likes}.pluck(:id)
    credit_type_id = xml_options('credit-type-id', {data: 'numeric', table: 'agreements'})
    number_ids = %w{20318% 40310% 51208% 51209% 51308% 51309% 51508% 51509% 51608% 51609% 51708% 51709% 51908% 51909% 47402________04% 47402________02%}
    AccountsDate
      .joins{account(Account).agreement}
      .where{(accounts.account_type == 'bad_loan') & (agreements.type == 'Agreement::Loan')}
      .where{number.like_any [
      .where([<<-SQL, {ids: dictionary_ids}])
        (
          (#{credit_type_id} IS NULL) OR
          (#{credit_type_id} NOT IN (:ids)) OR
          (#{credit_type_id} IN (:ids) AND agreements.start_date < '2010-01-12')
        )
        AND (
          #{number_ids.map{|n| "(number like '#{n}')"}.join('OR')}
          OR
          (number like '20317%' AND number NOT like '20317________03%' AND number NOT like '20317________04%')
          OR
          (number like '458%' AND number NOT like '45815%' AND number NOT like '45817%')
        )
      SQL
      .select('balance')
  end

end
