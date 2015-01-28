class Api::IndicatorRulesController < ApiController

  def index
    @indicator = Indicator.find(params[:indicator_id])
    @indicator_rules = @indicator.children_rules
    render json: @indicator_rules
  end

end
