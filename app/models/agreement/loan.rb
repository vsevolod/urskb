class Agreement::Loan < Agreement

   STORE_OPTIONS = {
     rule: 'Регламент',
     project_type: 'Тип проекта',
     rate: 'Ставка',
     direction_business_plan_id: 'Направление БП',
     credit_type_id: 'Тип кредита',
     limit_dept: 'Лимит задолженности',
     class_id: 'CLASS_ID',
     id_dog: 'ID_DOG'
   }

   store :xml_options, accessors: STORE_OPTIONS.keys, coder: XmlWrapper

   belongs_to_store :direction_business_plan
   belongs_to_store :credit_type

end
