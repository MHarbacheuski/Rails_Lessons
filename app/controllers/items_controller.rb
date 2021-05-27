class ItemsController < ApplicationController
  layout false
  skip_before_action :verify_authenticity_token
  before_action :find_item, only: %i[show edit update destroy upvote]
  before_action :admin?, only: %i[edit]
  after_action :show_info, only:%i[index]

  def index
    @items = Item.all
=begin
    render body: @items.map {|i|"#{i.name}:#{i.price}"}
=end
  end

  def create
    item = Item.create(items_params)
    if item.persisted?
      #render json: item.name, status:  :created
      if @item
        redirect_to item_path,status: :created
      end
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def new
  end

  def show
    #render body: 'ggg', status: 404 unless @item
  end

  def edit
    #render body: 'ggg', status: 404 unless @item
  end

  def update
    if @item.update(items_params)
    redirect_to item_path
    else
      render body:'Poka'
    end
  end

  def destroy
    if @item.destroy.destroyed?
      redirect_to items_path #redirect_to '/items'
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def upvote
    @item.increment! :votes_count
    redirect_to items_path
  end

  def expensive
    @items = Item.where("price<100")
    render :index
  end

  private

  def items_params
    params.permit(:name,:price,:real,:weight,:description)
  end

  def find_item
    @item = Item.where(id:params[:id]).first
    render_404 unless @item
  end

  def admin?
    render_403 unless params[:admin]
    #render json: "Access denied", status: :forbidden unless params[:admin]
  end

  def show_info
    puts "Index endpoint"
  end

end
