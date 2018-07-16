class Employee::IssuesController < ActionController::Base
  helper_method :current_employee
  layout "employee"
  before_action :authenticate_employee

  def index
    @issues = current_employee.issues
    @issues = @issues.paginate(page: params[:page])
  end

  def new
    @issue = current_employee.issues.build
    render layout: false if request.xhr?
  end

  def edit
    @issue = current_employee.issues.find(params[:id])
    render layout: false if request.xhr?
  end

  def show
    @issue = current_employee.issues.find(params[:id])
  end

  def create
    @issue = current_employee.issues.build(issue_params)

    if @issue.save
      redirect_back(fallback_location: root_path, flash: { success: t('create') }) unless request.xhr?
    else
      render :new
    end
  end

  def update
    @issue = current_employee.issues.find(params[:id])

    if @issue.update(issue_params)
      redirect_back(fallback_location: root_path, flash: { success: t('update') }) unless request.xhr?
    else
      render :edit
    end
  end

  def set_priority
    @issue = current_employee.issues.find(params[:id])
    @issue.update_attribute(:priority, params[:priority])

    if request.xhr?
      render nothing: true
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:item_id, :title, :description, :note, :priority)
  end

  def current_employee
    @current_employee ||= Employee.find(session[:employee_id]) if session[:employee_id]
  end

  def authenticate_employee
    redirect_to root_path unless current_employee.try(:active)
  end
end
