class GamesController < ApplicationController
  before_action :set_game, only: %i[ update destroy ]

  #The application is only an API meant to be interacted with from a dedicated frontend, requests going to / shouldn't return anything.
  def invalidEndpoint
    render plain: "Invalid endpoint."
  end

  # GET /games/allGames
  def index
    @games = Game.all
    render json: @games
  end

  # GET /games/searchGames?query_parameters
  def searchGames
    @parsedParams = request.query_parameters
    @games = Game.publisherSearch(@parsedParams['publisher']).releaseYearSearch(@parsedParams['releaseYear']).systemSearch(@parsedParams['system']).titleSearch(@parsedParams['title'])
    render json: @games
  end

  # POST /games/addGame
  def create
    @parsedReq = JSON.parse(request.raw_post)

    @game = Game.new(title: @parsedReq['title'], releaseYear: @parsedReq['releaseYear'], system: @parsedReq['system'], publisher: @parsedReq['publisher'])
    if @game.save
      render json: JSON.parse('{"success": true}'), status: :created
    else
      render json: JSON.parse('{"success": false}'), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/updateGame/:id
  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/deleteGame/:id
  def destroy
    puts request.body.read
    @game.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.expect(game: [ :title, :releaseYear, :system, :publisher ])
    end
end
