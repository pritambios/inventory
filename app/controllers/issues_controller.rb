class IssuesController < ApplicationController
  def index
    @issues = Issue.includes(:resolution, item: [:brand, :category])

    if params[:item_id].present?
      @item = Item.find(params[:item_id])
      @issues = @issues.where(item_id: @item.id)
    end

    @issues = @issues.paginate(page: params[:page])
  end

  def show
    issue
  end

  def new
    @issue = if (item = Item.find_by(id: params[:item_id]))
               item.issues.build
             else
               Issue.new
             end
  end

  def create
    @issue = Issue.new(issue_params)

    if request.xhr?
      @issue.save
    elsif @issue.save
      redirect_to :back, flash: { success: t('create') }
    else
      render 'new'
    end
  end

  def edit
    issue
  end

  def update
    if request.xhr?
      issue.update(issue_params)
    elsif issue.update(issue_params)
      redirect_to :back, flash: { success: t('update') }
    else
      render 'edit'
    end
  end

  def set_resolution
    issue.update_attribute(:resolution_id, params[:resolution_id])

    if request.xhr?
      render nothing: true
    end
  end

  def set_priority
    issue.update_attribute(:priority, params[:priority])

    if request.xhr?
      render nothing: true
    end
  end

  def close
    issue
  end

  def close_issue
    issue.closed_at = Time.zone.now

    if issue.update(resolution_params)
      redirect_to issues_path, flash: { success: t('close') }
    else
      render 'close'
    end
  end

  private

  def issue
    @issue ||= Issue.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:item_id, :title, :description, :priority, :employee_id)
  end

  def resolution_params
    params.require(:issue).permit(:resolution_id)
  end
end
