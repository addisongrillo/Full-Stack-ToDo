class CalendarsController < ApplicationController
  def show
    respond_to do |format|
      format.html
      format.json do
        start_date  = Date.parse(params[:start_date])
        end_date    = Date.parse(params[:end_date])
        tasks       = current_user.tasks.between(start_date, end_date)
        render json: tasks.ordered.group_by{ |task| task.due_date }
      end
    end
  end
end
