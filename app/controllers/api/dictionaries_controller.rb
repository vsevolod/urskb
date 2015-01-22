class Api::DictionariesController < ApiController

  def index
    @dictionaries = Dictionary.roots
    render json: @dictionaries
  end

  def children
    @dictionaries = Dictionary.find(params[:id]).children
    render json: @dictionaries
  end

  def show
    @dictionary = Dictionary.find(params[:id])
    render json: @dictionary
  end

  def create
    @dictionary = Dictionary.new(dictionary_attributes)
    if @dictionary.save
      render json: @dictionary
    else
      render_json_error @dictionary
    end
  end

  def update
    @dictionary = Dictionary.find(params[:id])
    if @dictionary.update_attributes dictionary_attributes
      render json: @dictionary
    else
      render_json_error @dictionary
    end
  end

  def destroy
    @dictionary = Dictionary.find(params[:id])
    if @dictionary.destroy
      render json: {status: 'Complete'}
    else
      render_json_error @dictionary
    end
  end

  private

    def dictionary_attributes
      params.require(:dictionary).permit(:name, :tag, :parent_id)
    end
end
