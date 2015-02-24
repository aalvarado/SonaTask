class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_task, only: [:show, :update, :destroy]

  def show
    respond_with @task
  end

  def index
    respond_with current_user.tasks
  end

  def create
    respond_with current_user.tasks.create(task_params)
  end

  def update
    @task.update_attributes task_params

    respond_with @task
  end

  def destroy
    respond_with @task.destroy
  end

  private

  def task_params
    params.require(:task).permit([
      :title,
      :body,
      :expiration,
      :completed_on,
      :position,
      tag_list: []
    ])
  end

  def find_task
    @task = current_user.tasks.find params[:id]
  end
end
