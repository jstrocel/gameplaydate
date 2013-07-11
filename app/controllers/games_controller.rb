class GamesController < ApplicationController
  before_action :signed_in_user
  
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game, :notice => "Successfully created game."
    else
      render :action => 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(game_params)
      redirect_to @game, :notice  => "Successfully updated game."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_url, :notice => "Successfully destroyed game."
  end
  
  private
  
      def game_params
        params.require(:game).permit(:name, :platform)
      end
end
