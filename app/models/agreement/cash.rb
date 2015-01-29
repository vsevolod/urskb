class Agreement::Cash < Agreement

  STORE_OPTIONS = {
    id_dog: 'ID_DOG',
  }

  store :xml_options, accessors: STORE_OPTIONS.keys, coder: XmlWrapper

end
