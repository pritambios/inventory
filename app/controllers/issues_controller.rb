class IssuesController < ApplicationController
  before_action :get_issue, only: [:edit, :update, :show, :destroy, :set_resolution, :set_priority, :close, :close_issue]

  def index
    @issues = Issue.includes(:system, :resolution, item: [:brand, :category])

    if params[:item_id].present?
      @item = Item.find(params[:item_id])
      @issues = @issues.where(item_id: @item.id)
    end

    @issues = @issues.paginate(page: params[:page])
  end

  def new
    if item = Item.find_by_id(params[:item_id])
      @issue = item.issues.build
    else
      @issue = Issue.new
    end
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

  def set_priority
    @issue.update_attribute(:priority, params[:priority])
  end

  def close_issue
    @issue.closed_at = Time.now

    if @issue.update_attributes(resolution_params)
      redirect_to issues_path, flash: { success: "Issue Closed" }
    else
      render 'close'
    end
  end

  private

  def get_issue
    @issue = Issue.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:item_id, :system_id, :title, :description, :note, :priority)
  end

  def resolution_params
    params.require(:issue).permit(:resolution_id)
  end
end
