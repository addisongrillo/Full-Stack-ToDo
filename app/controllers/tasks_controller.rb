class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]
  before_action :set_tasks, only: [:index]


  # GET /tasks
  def index
    page      = (params[:page] || 1).to_i
    per_page  = 5
    @tasks    = @tasks.paginate(page: page, per_page: per_page)
    @task     = Task.new
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

  def set_tasks
    @tasks  = Task.all.ordered
    @tasks  = case params[:status]
              when "completed"
                @tasks.completed
              when "pending"
                @tasks.pending
              else
                @tasks
              end
    @tasks  = case params[:due]
              when "past_due"
                @tasks.past_due
              when "due_soon"
                @tasks.due_soon
              when "due_later"
                @tasks.due_later
              when "not_due"
                @tasks.not_due
              else
                @tasks
              end
    @tasks  = @tasks.search(params[:term])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:description, :due_date)
  end
end
