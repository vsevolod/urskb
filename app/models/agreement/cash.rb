class Agreement::Cash < Agreement

  STORE_OPTIONS = {
    id_dog: 'ID_DOG',
  }

  store :options, accessors: STORE_OPTIONS.keys

end
