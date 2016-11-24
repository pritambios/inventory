class IssuesController < ApplicationController
  before_action :get_issue, only: [:edit, :update, :show, :destroy, :set_resolution]

  def index
    @issues = Issue.includes(:system, :resolution, item: [:brand, :category])
    @issues = @issues.where(item_id: params[:item_id]) if params[:item_id].present?
    @issues = @issues.paginate(page: params[:page])
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      redirect_back(fallback_location: root_path, flash: { success: "Issue has been Created Successfully!" })
    else
      render 'new'
    end
  end

  def update
    if @issue.update(issue_params)
      redirect_back(fallback_location: root_path, flash: { success: "Issue was successfully updated" })
    else
      render 'edit'
    end
  end

  def destroy
    if @issue.destroy
      flash[:success] = "Issue was successfully deleted"
      redirect_to issues_path
    else
      flash[:danger] = "Sorry!! not able to delete"
      redirect_to issues_path
    end
  end

  def set_resolution
    @issue.update_attribute(:resolution_id, params[:resolution_id])
  end

  private

  def get_issue
    @issue = Issue.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:item_id, :system_id, :title, :description, :closed_at, :note, :resolution_id)
  end
end
