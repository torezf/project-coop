class TodolistsController < ApplicationController
  before_action :set_todolist, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_root

  def index
    @todolists = Todolist.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show; end

  def new
  end

  def edit; end
  def create
    @todolist = Todolist.new(todolist_params)
    respond_to do |format|
      if @todolist.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("todolist_list", partial: "list_item", locals: { item: @todolist }),
            turbo_stream.replace("new_todolist_form", partial: "form", locals: { todolist: Todolist.new })
          ]
        end
        format.html { redirect_to todolists_path }
      end
    end
  end



  def update
    @todolist = Todolist.find(params[:id])
    if @todolist.update(todolist_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            helpers.dom_id(@todolist),
            partial: "list_item",
            locals: { item: @todolist }
          )
        end
        format.html { redirect_to todolists_path }
      end
    end
  end


  def destroy
    @todolist = Todolist.find(params[:id])
    @todolist.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(helpers.dom_id(@todolist))
      end
      format.html { redirect_to todolists_path }
    end
  end



  private

  def set_todolist
    @todolist = Todolist.find(params[:id])
  end

  def todolist_params
    params.require(:todolist).permit(:content, :checklist)
  end

  def redirect_root
    redirect_to root_path
  end
end
