class GamesController < ApplicationController
  before_action :set_game, only: %i[ show update destroy ]

  # GET /games
  def index
    @games = Game.all

    render json: @games
  end

  def show
    #empty
  end

  # GET /games/1
  def searchGames
    @parsedParams = request.query_parameters
    @games = Game.publisherSearch(@parsedParams['publisher']).releaseYearSearch(@parsedParams['releaseYear']).systemSearch(@parsedParams['system']).titleSearch(@parsedParams['title'])
    render json: @games
  end

  # POST /games
  def create
    @parsedReq = JSON.parse(request.raw_post)

    @game = Game.new(title: @parsedReq['title'], releaseYear: @parsedReq['releaseYear'], system: @parsedReq['system'], publisher: @parsedReq['publisher'])
    if @game.save
      render json: JSON.parse('{"success": true}'), status: :created
    else
      render json: JSON.parse('{"success": false}'), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
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
