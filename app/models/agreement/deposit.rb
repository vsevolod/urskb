class Agreement::Deposit < Agreement

   STORE_OPTIONS = {
     id_dog: 'ID_DOG',
     class_id: 'CLASS_ID',
     agreement_mode_id: 'Вид договора',
     conclusion_date: 'Дата заключения',
     term_fact: 'Срок',
     term_plan: 'Срок по условию договора',
     early_denunciation: 'Возможность досрочного расторжения',
     early_denunciation_date: 'Дата досрочного расторжения',
     percent_plan: 'Проц схема',
     percent: 'Процент',
     balance_of_account: 'Остаток при закрытии'
   }

  store :xml_options, accessors: STORE_OPTIONS.keys, coder: XmlWrapper

   belongs_to_store :agreement_mode

end
