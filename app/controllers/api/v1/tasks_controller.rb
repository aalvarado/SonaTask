class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_task, only: [:show, :update, :destroy]

  def show
    respond_with @task
  end

  def index
    @tasks = current_user.tasks
    @tasks = @tasks.basic_search(basic_search) if basic_search.present?

    paginate_with @tasks
  end

  def create
    task = current_user.tasks.create(task_params)
    respond_with task
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
      tag_list: [],
      attachments_attributes: [:id, file: [:data, :content_type, :filename]]
    ])
  end

  def basic_search
    params[:basic_search].to_s.squeeze(' ').strip.gsub(/[^\w\s]/, '')
  end

  def find_task
    @task = current_user.tasks.find params[:id]
  end
end
