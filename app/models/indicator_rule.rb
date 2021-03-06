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
    result = get_records_dates
    result = result.where{(date == my{options[:on]})}   if options[:on]
    result = result.where{(date >= my{options[:from]})} if options[:from]
    result = result.where{(date <= my{options[:to]})}   if options[:to]
    result = result.where{(agreements.client_id == my{options[:client_id]})} if options[:client_id]
    result.inject(0){|sum, ad| sum + ad.balance.to_i}
  end

  private

    # Подсчет показателей
    # TODO Вынести в отдельную библиотеку
  
    def get_records_dates()
      case self.old_id
      when 'PokRules::19'
        PokRules::Pr19.sql
      when 'PokRules::21'
        PokRules::Pr21.sql
      when 'PokRules::101'
        PokRules::Pr101.sql
      end
    end

end
