class Api::V1::Tasks::AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_task
  before_action :find_attachment, only: [:show, :update, :destroy]

  def show
    respond_with @attachment
  end

  def index
    respond_with @task.attachments
  end

  def create
    attachment = @task.attachments.create(attachment_params)
    respond_with attachment, location: task_attachment_url(@task, attachment)
  end

  def update
    @attachment.update_attributes attachment_params

    respond_with @attachment, location: task_attachment_url(@task, @attachment)
  end

  def destroy
    respond_with @attachment.destroy
  end

  private

  def attachment_params
    params.require(:attachment).permit([
      { file: [ :data, :filename, :content_type] }
    ])
  end

  def find_task
    @task = current_user.tasks.find(params[:task_id])
  end

  def find_attachment
    @attachment = @task.attachments.find params[:id]
  end
end
