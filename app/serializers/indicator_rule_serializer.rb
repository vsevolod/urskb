class IndicatorRuleSerializer < ActiveModel::Serializer

  attributes :level, :start_date, :end_date, :sql, :ready, :child_indicator_id, :child_name

  def child_name
    object.child.try(:name) || 'Без названия'
  end

  def sql
    txt = "SELECT #{object.sql_column}"
    txt += "/#{object.sql_divider}" if object.sql_divider.present?
    txt += object.sql_formul if object.sql_formul.present?
    txt += " FROM #{object.sql_from} "
    txt += object.sql_where if object.sql_where.present?
    txt if txt != 'SELECT  FROM  '
  end

end
