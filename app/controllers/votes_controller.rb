class VotesController < ApplicationController
  # before_action :set_vote, only: [:show, :edit, :update, :destroy]
  before_action :basic_auth, except: [:create]
  
  def index
    @votes = Vote.all
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.group_id = 0 # とりあえず
    @vote.user_id = vote_params[:user_id]
    @vote.value = vote_params[:value]
    @vote.url = vote_params[:url]
    if @vote.save
      render json: {status: 'ok'}
    else
      render json: {status: 'ng'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:user_id, :value, :url)
    end
end
