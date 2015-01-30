# ready - Готов для расчета (только для индикаторов нижнего уровня)
class IndicatorRule < ActiveRecord::Base

  STORE_OPTIONS = {
    sql_from: 'Таблица',
    sql_column: 'Колонка',
    sql_divider: 'Делитель колонки',
    sql_formul: 'Доп. действия',
    sql_where: 'Условия'
  }

  store :options, accessors: STORE_OPTIONS.keys

  belongs_to :child,  foreign_key: 'child_indicator_id',  class_name: 'Indicator'
  belongs_to :parent, foreign_key: 'parent_indicator_id', class_name: 'Indicator'

  scope :on, lambda{|date| where{((start_date == nil) | (start_date <= date)) & ((end_date == nil) | (end_date >= date))} }

  #validates :parent_indicator_id, uniqueness: {scope: [:child_indicator_id]}

  def active?(date = Date.today)
    self.start_date >= date && (!self.end_date || self.end_date < date)
  end

  # Подсчет по правилу показателя
  def calculate(options)
    get_accounts_dates.where{(date == my{options[:on]}) & (agreements.client_id == my{options[:client_id]})}.inject(0){|sum, ad| sum + ad.balance.to_i}
  end

  private

    # Подсчет показателей
    # TODO Вынести в отдельную библиотеку
  
    def get_accounts_dates()
      case self.old_id
      when 'PokRules::21'
        dictionary_likes = %w{(1221% 1597-р% 1598-р% 1710-р% 1712-р% Бизнес-овердрафт%} 
        dictionary_ids = Dictionary['loan_credit_type'].children.where{name.not_like_all dictionary_likes}.pluck(:id)
        credit_type_id = xml_options('credit-type-id', {data: 'numeric', table: 'agreements'})
        AccountsDate
          .joins(account: :agreement)
          .where{(accounts.account_type == 'bad_loan') & (agreements.type == 'Agreement::Loan')}
          .where([<<-SQL, {ids: dictionary_ids}])
            (#{credit_type_id} IS NULL) OR
            (#{credit_type_id} IN (:ids)) OR
            (#{credit_type_id} NOT IN (:ids) AND agreements.start_date < '2010-01-12')
          SQL
          .select('balance')
      end
    end

    def xml_options(node, options = {})
      options = {data: 'varchar', table: nil}.merge(options)
      options[:table] += '.' if options[:table]
      "#{options[:table]}xml_options.value('(/hash/#{node}/node())[1]', '#{options[:data]}')"
    end

end
