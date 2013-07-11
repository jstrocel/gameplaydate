class GameOwnershipsController < ApplicationController
  before_action :signed_in_user
  
  def create
    #debugger
      @game = Game.find(params[:game_ownership][:game_id])
      current_user.claim_game!(@game)
      respond_to do |format|
        format.html { redirect_to @game }
        format.js
      end
  end

  def destroy
      @game = GameOwnership.find(params[:id]).game
      current_user.unclaim_game!(@game)
      respond_to do |format|
        format.html { redirect_to @game}
        format.js
      end
    end
end
