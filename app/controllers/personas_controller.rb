class PersonasController < ApplicationController
   before_action :signed_in_user
  
  def index
    @personas = current_user.personas
  end

  def show
    @persona = Persona.find(params[:id])
  end

  def new
    @persona = Persona.new
    @games = current_user.games
  end

  def create
    @games = current_user.games
    @persona = current_user.personas.build(persona_params)
    if @persona.save
      redirect_to current_user, :notice => "Successfully created persona."
    else
      render :action => 'new'
    end
  end

  def edit
    @persona = Persona.find(params[:id])
    @games = current_user.games
  end

  def update
    @persona = Persona.find(params[:id])
    if @persona.update_attributes(persona_params)
      redirect_to @persona, :notice  => "Successfully updated persona."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @persona = Persona.find(params[:id])
    @persona.destroy
    redirect_to current_user, :notice => "Successfully destroyed persona."
  end
  
  private


    def persona_params
      allowed_attributes = [:user_id, :game_id, :name, :persona, :game, :server]
      params.require(:persona).permit(allowed_attributes)
    end
  
end
