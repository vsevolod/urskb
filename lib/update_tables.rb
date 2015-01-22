require './lib/tables_hash'

module UpdateTables
  include TablesHash

  def update_table(file, table)
    connection = AdodbConnection.new(file)
    table_options = TABLES[table]

    # Берем все записи из таблицы
    connection.each("SELECT * FROM #{table}", table_options[:sql]) do |row|
      conditions = {}
      record = if table_options[:find_by]
                 table_options[:find_by].call(table_options[:model], row)
               else
                 options = table_options[:to][:old_id][:options]
                 table_options[:model].where(old_id: "#{options[:table] || table}::#{row[options[:field]]}").first_or_initialize
               end
      # Идем по всем полям, которые необходимо обработать для записи
      table_options[:to].each_pair do |key, value|
        if value.is_a? String
          conditions[key] = row[value]
        elsif value.is_a? Proc
          conditions[key] = value.call(row)
        elsif value.is_a? Hash
          options = value[:options]
          case value[:type]
          when 'to_dictionary'
            # Переносим из таблицы в Dictionary
            parent = Dictionary.where(options).first_or_initialize(name: options[:old_name])
            save_object(parent)
            object = parent.children.where(name: row[options[:old_name]]).first_or_initialize
            save_object(object)

            conditions[key] = object.id
          when 'from_table'
            # Переносим из связанной таблицы
            # Условие - запись УЖЕ должна быть в таблице
            object = parent_options(row, options, options[:table], TABLES[options[:table]][:model])
            conditions[key] = object.id if object && !object.new_record?
          when 'old_id'
            # Поле old_id: уникально. Содержит название таблицы и id
            conditions[key] = "#{options[:table] || table}::#{row[options[:field]]}"
          end
        end
      end

      if table_options[:additional]
        if table_options[:additional][:tag]
          parent = Dictionary.where(name: table, old_name: table, tag: table_options[:additional][:tag]).first_or_initialize
          save_object(parent)
          record.parent = parent unless parent.new_record?
        end
        if table_options[:additional][:ancestry]
          parent = parent_options(row, table_options[:additional][:ancestry], table, table_options[:model])
          record.parent = parent unless parent.new_record?
        end
      end

      record.attributes = conditions
      save_object(record)
      if table_options[:additional] && table_options[:additional][:after_save] && !record.new_record?
        table_options[:additional][:after_save].call(record, row)
      end
    end
    
  end

  def save_object(object)
    if object.new_record?
      binding.pry
      if object.save
        if object.class.name == 'Dictionary'
          print 'D'
        else
          print '.'
        end
      else
        array = object.errors.full_messages
        if array.size == 1 && array.include?("Name can't be blank")
          true
        else
          print 'E'
        end
      end
    else
      if object.changes.any?
        if object.save
          print 'U'
        else
          print 'E'
        end
      else
        print '*'
      end
    end
  end

  def parent_options(row, options, from_table, model_klass)
    where_opts = {}
    if options[:primary_key]
      where_opts[options[:primary_key]] = row[options[:foreign_key]]
    else
      where_opts[:old_id] = "#{options[:from_table] || from_table}::#{row[options[:foreign_key]]}" 
    end

    model_klass.where(where_opts).first_or_initialize
  end

end
