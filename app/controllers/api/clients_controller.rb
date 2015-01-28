class Api::ClientsController < ApiController

  def index
    @clients = Client.all
    if params[:search]
      %w{name inn kpp}.each do |attr|
        search = JSON.parse(params[:search])
        next unless search[attr]
        @clients = @clients.where("#{attr} like ?",  "%#{search[attr]}%") 
      end
    end
    render json: @clients.count > 10 ? [{name: 'Количество клиентов больше 10'}] : @clients
    #render json: @clients
  end

  def show
    @client = Client.find(params[:id])
    render json: @client
  end

end
