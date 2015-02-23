class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!

  def show
    respond_with current_user.tasks.find params[:id]
  end

  def index
    respond_with current_user.tasks
  end

  def create
    respond_with current_user.tasks.create(task_params)
  end

  def update
    task = current_user.tasks.find params[:id]
    task.update_attributes task_params

    respond_with task
  end

  private

  def task_params
    params.require(:task).permit([
      :title,
      :body,
      :expiration,
      :completed_on,
      :position,
    ])
  end
end
