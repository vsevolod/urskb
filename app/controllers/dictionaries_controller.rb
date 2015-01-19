class DictionariesController < ApplicationController

  def index
    @dictionaries = Dictionary.roots
  end

end
