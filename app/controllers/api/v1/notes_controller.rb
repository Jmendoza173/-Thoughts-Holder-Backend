class Api::V1::NotesController < ApplicationController
  before_action :set_note, only: [:show,:update,:destroy]

  def index
    if logged_in?
      notes = Note.all
      render json: notes, status: 200
    else
      render json: { go_away: true }, status: :unauthorized
    end
  end

  def create
    if logged_in?
      note = Note.create(note_params)
      render json: note, status: 201
    else
      render json: { go_away: true }, status: :unauthorized
    end
  end

  def update
    if logged_in_user_id == @note.user_id
      @note.update(note_params)
      render json: @note, status: 200
    else
      render json: { go_away: true }, status: :unauthorized
    end
  end

  def destroy
    if logged_in_user_id == @note.user_id
      noteId = @note.id
      @note.destroy
      render json: {message: "Zap! Note deleted", noteId: noteId}
    else
      render json: { go_away: true }, status: :unauthorized
    end
  end

  def show
    if logged_in_user_id == @note.user_id
      render json: @note, status: 200
    else
      render json: { go_away: true }, status: :unauthorized
    end
  end

  private
  def note_params
    params.permit(:body, :title, :user_id, :post)
  end

     
end
