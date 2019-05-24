class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]

  # GET /tasks
  def index
    @tasks = case params[:status]
                  when "completed"
                    Task.completed
                  when "pending"
                    Task.pending
                  else
                    Task.all
                  end
    @task  = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_back fallback_location: root_path, notice: 'Task was successfully created.'
    else
      redirect_back fallback_location: root_path, alert: @task.errors.full_messages.to_sentence
    end
  end
  
  # PUT/PATCH /tasks/1
  def update
    @task.update(completed: !@task.completed)
    redirect_back fallback_location: root_path,
      notice: 'Task was successfully updated.'
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to root_path, notice: 'Task was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:description, :due_date)
  end
end
