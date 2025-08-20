class TodolistsController < ApplicationController
  before_action :set_todolist, only: %i[ show edit update destroy complete ]

  def index
    @todolists = Todolist.order(created_at: :desc)
  end

  def show; end
  def new
    @todolist = Todolist.new
  end
  def edit; end

  def create
    @todolist = Todolist.new(content: params[:content]) # ใช้ params[:content] ตรงๆ เลย
    if @todolist.save
      redirect_to todolists_path, notice: "Todolist was successfully created."
    else
      render :index, status: :unprocessable_entity
    end
  end
  # และลบบรรทัด params.require... ออก

  def update
    if @todolist.update(todolist_params)
      redirect_to todolists_path, notice: "Todolist was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todolist.destroy!
    redirect_to todolists_path, notice: "Todolist was successfully destroyed."
  end

  # เพิ่ม action complete
  def complete
    @todolist.update(checklist: true)
    redirect_to todolists_path
  end

  private

    def set_todolist
      @todolist = Todolist.find(params[:id])
    end
end
