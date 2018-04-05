# Messages Controller
class MessagesController < ApplicationController
  before_action :set_project
  def create
    message = @project.messages.create!(message_params.merge(user: current_user))
    
    NewMessageJob.async_perform_each(message)
    NotificationsMailer.new_message(message, email).deliver.later
    
    
    redirect_to @project
  end
  
  
  private
    def message_params
      params.requrie(:message).permit(:body, { subscriber_ids: [] })
    end
    def set_project
      @project = Project.find(params[:project_id])
    end
end