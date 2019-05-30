class SubTasksController < ApplicationController
  before_action :set_sub_task, only: [:update, :destroy]

  def create
    @sub_task = SubTask.new(sub_task_params)
    @sub_task.task_id = params[:task_id]
    if @sub_task.save
      redirect_back fallback_location: root_path, notice: 'SubTask was successfully created.'
    else
      redirect_back fallback_location: root_path, alert: @sub_task.errors.full_messages.to_sentence
    end
  end

  def index
    @task = current_user.tasks.find(params[:task_id])
    @sub_task = SubTask.new
  end

  def update
    @sub_task.update(completed: !@sub_task.completed)
    redirect_back fallback_location: root_path,
      notice: 'SubTask was successfully updated.'
  end

  def destroy
    @sub_task.destroy
    redirect_back fallback_location: root_path,
    notice: 'SubTask was successfully destroyed.'
  end

  private

  def set_sub_task
    @sub_task = SubTask.find(params[:id])
  end

  def sub_task_params
    params.require(:sub_task).permit(:description)
  end

end
