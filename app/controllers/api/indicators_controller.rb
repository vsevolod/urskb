class Api::IndicatorsController < ApiController

  def index
    @indicators = Indicator.roots
    render json: @indicators
  end

  def children
    @indicators = Indicator.find(params[:id]).children
    render json: @indicators
  end

  def show
    @indicator = Indicator.find(params[:id])
    render json: @indicator
  end

  def create
    @indicator = Indicator.new(indicator_attributes)
    if @indicator.save
      render json: @indicator
    else
      render_json_error @indicator
    end
  end

  def update
    @indicator = Indicator.find(params[:id])
    if @indicator.update_attributes indicator_attributes
      render json: @indicator
    else
      render_json_error @indicator
    end
  end

  def destroy
    @indicator = Indicator.find(params[:id])
    if @indicator.destroy
      render json: {status: 'Complete'}
    else
      render_json_error @indicator
    end
  end

  private

    def indicator_attributes
      params.require(:indicator).permit(:name, :tag, :parent_id, :value)
    end
end
