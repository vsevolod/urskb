class Api::DictionariesController < ApplicationController

  def index
    @dictionaries = Dictionary.roots
    render json: @dictionaries
  end

  def show
    @dictionary = Dictionary.where(params[:dictionary]).first
    render json: @dictionary
  end
end
