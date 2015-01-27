# Структура TABLES:
# <<Название таблицы в старой БД>>: {
#   model: <<Название модели в новой БД>>
#   to: {
#     <<Поле в новой БД>>: <<Поле в старой БД>> или <<Метод для работы.>>
#   }
#   find_by: Proc.new{|_model, row| ... } # Вместо стандартного поиска по old_id, ищется по блоку
#   additional: {} # Хэш дополнительных условий
#   sql: {Sort: ''} # Хэш, который подмешивается к SQL запросу
# }
# 
# Типы значение полей
# String - Строка, значение приравнивается напрямую
# Proc - Блок кода, в который передается row при обработке. Должен возвращать значение для поля
# Hash
#   to_dictionary
#            Используется при связывании с таблицей Dictionary. Если старые числовые значения передаются в Dictionary
#              tag: Таг парента в таблице Dictionary, к которому надо прикреплять новое значение
#              old_name: Колонка в старой таблице, откуда необходимо брать значение
#   from_table
#            Используется для связывания с другой таблицей
#              foreign_key: Вторичный ключ, который ссылается на таблицу связи
#              table: Сама таблица связи
#              primary_key: Первичный ключ в новой таблице
#   old_id
#           Добавляет old_id. ССвязь со старой таблицей/ключом
#              field: Поле первичной таблицы
# Additional
#   after_save (object, row)
#           Выполняется блок кода после сохранения/изменения объекта

require './config/environment'

# Функция для добавления клиента
# TODO Добавить вычисление правовой формы из имени
def get_client_proc(options = {})
  options = {old_id: 'ID_CLIENT', name: 'Наименование', inn: 'ИНН', kpp: 'КПП', id_crm: 'ID_CRM'}.merge(options)
  Proc.new{|row|
    client = Client.where(old_id: row[options[:old_id]]).first_or_initialize
    options.each do |k, v|
      client.send("#{k}=", row[v])
    end
    client.save
    client.id
  }
end

# Функция для вычисления статуса договора
def get_agreement_state_proc(field)
  Proc.new{|row|
    case row[field]
    when 'Закрыт' then 'closed'
    when 'Открыт' then 'open'
    when 'Зарезервирован дистанционно' then 'reserved'
    when 'Помечен к открытию' then 'marked_for_open'
    when 'Помечен к закрытию' then 'marked_for_close'
    else
      'worked'
    end
  }
end

# Функция для вычисления подразделения из таблицы Options по ключу report_names
def get_agreement_division_proc(field)
  Proc.new{|row|
    object_hash[row[field]] ||= Option.where(objectable_type: 'Division', key: 'report_names', value: row[field]).first.try(:objectable_id)
    object_hash[row[field]]
  }
end

module TablesHash

  TABLES = {
    'Pokazat' => {
      model: Indicator,
      to: {
        old_id: {type: 'old_id', options: {field: 'IDPokazat'}},
        name: 'NamePokazat',
        sh_name: 'ShNamePokazat',
        comment: 'Comment',
        sign_type_id:   {type: 'to_dictionary', options: {tag: 'indicator_sign',        old_name: 'SignPokazat'}},
        date_type_id:   {type: 'to_dictionary', options: {tag: 'indicator_date_type',   old_name: 'TipPokazat'}},
        product_id:     {type: 'to_dictionary', options: {tag: 'indicator_product',     old_name: 'IDProduct'}},
        accum_level_id: {type: 'to_dictionary', options: {tag: 'indicator_accum_level', old_name: 'AccumMaxLev'}},
        object_type_id: {type: 'from_table',      options: {foreign_key: 'IDPokazatVar', table: 'PokazatVar'}}
      }
    },
    'PokazatVar' => {
      model: Dictionary,
      to: {
        old_id: {type: 'old_id', options: {field: 'IDPokazatVar'}},
        name: 'NPokazatVar'
      },
      additional: {
        tag: 'indicator_type' # Тэг для рутового элемента в таблице Dictionary
      }
    },
    'SegmentGroup' => {
      model: Dictionary,
      to: {
        old_id: {type: 'old_id', options: {field: 'IDSegmGrp'}},
        name: 'nSegmGrp'
      },
      additional: {
        tag: 'group_segments' # Тэг для рутового элемента в таблице Dictionary
      }
    },
    'Segment' => {
      model: Dictionary,
      to: {
        old_id: {type: 'old_id', options: {field: 'IDSegment'}},
        name: 'NameSegment'
      },
      additional: {
        ancestry: {foreign_key: 'IDSegmGrp', from_table: 'SegmentGroup'}
      }
    },
    'PokRules' => {
      model: IndicatorRule,
      to: {
        old_id: {type: 'old_id', options: {field: 'IDRule'}},
        parent_indicator_id: {type: 'from_table', options: {foreign_key: 'IDMainPok', table: 'Pokazat'}},
        child_indicator_id: {type: 'from_table', options: {foreign_key: 'IDSubPok', table: 'Pokazat'}},
        start_date: 'sDate',
        end_date: 'eDate',
        level:  Proc.new{|row| row['TypeRule'].to_i}
      }
    },
    'Podrazd' => {
      model: Division,
      to: {
        old_id: {type: 'old_id', options: {field: 'IDPodrazd'}},
        name: 'NamePodrazd',
        number: 'Number',
        open_date: 'DateOpen',
        close_date: 'DateOff',
        comment: 'Comment',
        old_name: 'NameBefReorg',
        old_number: 'NumberBefReorg',
        object_type_id: {type: 'to_dictionary', options: {tag: 'division_object_type', old_name: 'TypePodrazd'}},
        state: Proc.new{|row| row['Status'] == 'работает' ? :worked : :closed},
        fl_ato: Proc.new{|row| row['flAto'] == 'да'}
      },
      additional: {
        ancestry: {foreign_key: 'IDParent'} # Назначать родителем по полю IDParent, которое берется из поля old_id
      }
    },
    'PodrazdNames' => {
      model: Division,
      to: {
        old_id: {type: 'old_id', options: {table: 'Podrazd', field: 'IDPodrazd'}},
        add_to_report_names: 'NameInReport'
      }
    },
    # START ============== Договоры ====================
    '66_krAccDog' => {
      sql: {'Sort' => 'ID_UPDOG'},
      model: Agreement::Loan,
      to: {
        old_id: {type: 'old_id', options: {field: 'ID_DOG'}},
        id_dog: 'ID_DOG',
        class_id: 'CLASS_ID',
        client_id: get_client_proc(),
        number: 'Номер договора',
        division_id: get_agreement_division_proc('Подразделение'),
        state: get_agreement_state_proc('Статус договора'),
        rule: 'Тип проекта',
        project_type: {type: 'to_dictionary', options: {tag: 'loan_project_type', old_name: 'Тип проекта'}},
        rate: 'Ставка',
        start_date: 'Дата начала',
        end_date_plan: 'Дата окончания',
        end_date_fact: 'Дата закрытия',
        updog: 'ID_UPDOG',
        direction_business_plan_id: {type: 'to_dictionary', options: {tag: 'loan_direction_business_plan', old_name: 'Направление БП'}},
        credit_type_id: {type: 'to_dictionary', options: {tag: 'loan_credit_type', old_name: 'Тип кредита'}},
        currency_id: {type: 'to_dictionary', options: {tag: 'currency', old_name: 'Валюта'}},
        sum: 'Сумма договора',
        limit_dept: 'Лимит задолженности'
      },
      additional: {
        after_save: Proc.new{|object, row|
          # Добавляем пустой счет
          account = object.accounts.f(old_id: row['ID_ACC'], number: row['Номер счета'])
          if account.new_record?
            account.collection = row['ID_COLLACC']
            account.start_date = row['Начало действия счета']
            account.name       = Dictionary.find_or_create_by_tag('accounts_name', row['Наименование счета'])
            account.save
          end

          # Выставляем предка
          if object.updog && object.ancestry.blank? && (parent = object.class.find_by_old_id("66_krAccDog::#{object.updog}"))
            if parent != object.parent
              object.parent = parent
              object.save
            end
          end
        }
      }
    },
    '55_spisDep_IB' => {
      model: Agreement::Deposit,
      to: {
        old_id: {type: 'old_id', options: {field: 'ID_DOG'}},
        id_dog: 'ID_DOG',
        class_id: 'CLASS_ID',
        client_id: get_client_proc({name: 'Клиент'}),
        number: 'Номер',
        currency_id: {type: 'to_dictionary', options: {tag: 'currency', old_name: 'Вал'}},
        sum: 'Сумма',
        conclusion_date: 'Дата заключения',
        start_date: 'Дата начала',
        end_date_plan: 'Дата окончания',
        end_date_fact: 'Дата закрытия',
        term_fact: 'Срок',
        term_plan: 'Срок по усл договора',
        early_denunciation: 'Возм доср раст',
        percent_plan: 'Проц схема',
        percent: 'Процент',
        state: get_agreement_state_proc('Статус'),
        division_id: get_agreement_division_proc('Подразделение'),
        balance_of_account: 'Тек ост при закр',
      },
      additional: {
        after_save: Proc.new{|object, row|
          # Добавляем пустые счета
          {'ID_ACC' => 'Счет', 'ID_INTACC' => 'Счет процентов', 'ID_INTR' => 'Счет расходов'}.each do |old_id, number|
            object.accounts.f(old_id: row[old_id], number: row[number]).save
          end
        }
      }
    },
    '34_407_474_426_Ib' => {
      model: Agreement::Cash,
      to: {
        old_id: {type: 'old_id', options: {field: 'ID'}},
        id_dog: 'ID',
        number: 'Номер договора',
        client_id: get_client_proc({name: 'Клиент'}),
        division_id: get_agreement_division_proc('Подразделение'),
        start_date: 'Дата заключения',
        end_date_plan: 'Дата окончания действия',
        end_date_fact: 'Дата закрытия',
        state: get_agreement_state_proc('Статус')
      },
      additional: {
        after_save: Proc.new{|object, row|
          # Добавляем пустые счета
          object.accounts.f(old_id: row['ID_RASCH'], number: row['Расчетный счет']).save
          object.accounts.f(number: row['Счет процентов']).save
          object.accounts.f(number: row['Счет требований']).save
        }
      }
    },
    # END ================ Договоры ====================
    
    # START ================ Счета =====================
    '53_krOstSr_IB' => {
      model: Account,
      find_by: Proc.new{|_model, row| _model.f(old_id: row['ID_ACC'], number: row['Основной номер'])},
      to: {
        old_id: 'ID_ACC',
        number: 'Основной номер',
        account_type: Proc.new{|row| Dictionary['account_type_regexp'].children.find{|d| row['Основной номер'] !~ Regexp.new(d.value)}.tag.gsub('_regexp', '')},
        currency_id: {type: 'to_dictionary', options: {tag: 'currency', old_name: 'Вал'}},
        statement_id: 'ID_VIP',
        start_date: 'Дата открытия',
        end_date: 'Дата закрытия',
        state: get_agreement_state_proc('Обобщенный статус'),
        vsb_id: 'ID_VSB',
        orgstruct_code: 'Код оргструкт',
        note: 'Примечания',
        class_id: 'CLASS_ID',
        consolidate_account: 'Сводный счет Основной номер',
        filial: 'Филиал Условный номер',
        account_client_id: get_client_proc(),
        owner_id: get_client_proc({old_id: 'ID_CLIENT_RASCH', name: 'Клиент для расчетов', inn: 'ИНН клиента для расчетов', kpp: 'КПП клиента для расчетов', id_crm: 'ID_CRM', okpo: 'ОКПО клиента для расчетов', ogrn: 'ОГРН клиента для расчетов'}),
        agreement_id: {type: 'from_table', options: {foreign_key: 'ID_DOG', table: '66_krAccDog'}}
      },
      additional: {
        after_save: Proc.new{|object, row|
          # Добавляем AccountsDate
          accounts_date = object.accounts_dates.where(date: row['Дата']).first_or_initialize
          accounts_date.currency_balance = row['Остаток в валюте счета']
          accounts_date.rate = row['Курс']
          accounts_date.balance = row['Остаток в основной валюте']
          accounts_date.division_id = get_agreement_division_proc('Код подр').call(row)
          accounts_date.save
        }
      }
    }
    # END ================== Счета =====================
  }

  @@object_hash = {}

  def object_hash
    @@object_hash
  end

end
