class TasksController < ApplicationController
  before_action :set_task, only: [:destroy]

  # GET /tasks
  def index
    @tasks = Task.all
    @task  = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to root_url, notice: 'Task was successfully created.'
  end


  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to root_url, notice: 'Task was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:description)
  end
end
