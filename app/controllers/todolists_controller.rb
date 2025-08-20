class TodolistsController < ApplicationController
  before_action :set_todolist, only: %i[show edit update destroy]

  def index
    @todolists = Todolist.order(created_at: :desc)
  end

  def show; end

  def new
  end

  def edit; end

  def create
    @todolist = Todolist.new(todolist_params)
    if @todolist.save
      redirect_to todolists_path, notice: "Todolist was successfully created."
    end
  end

  def update
    if @todolist.update(todolist_params)
      redirect_to todolists_path, notice: "Todolist was successfully updated."
    end
  end

  def destroy
    @todolist.destroy!
    redirect_to todolists_path, notice: "Todolist was successfully destroyed."
  end

  private

  def set_todolist
    @todolist = Todolist.find(params[:id])
  end

  def todolist_params
    params.require(:todolist).permit(:content, :checklist)
  end
end
