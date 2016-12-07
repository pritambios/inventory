module ApplicationHelper
  def back_link
    link_to ('<i class="fa fa-arrow-left"></i> Back').html_safe, :back
  end

  def delete_link(path)
     link_to ('<i class="fa fa-trash" title="Delete Details"></i> Delete').html_safe, path, method: :delete,
                data: { confirm: "Are you sure?" }, class: 'btn btn-danger btn-sm'
  end

  def edit_link(path, title = "Details")
    link_to ('<i class="fa fa-edit" title="Edit Details"></i> Edit').html_safe, path, data: { remote_popup: true, title: "Edit #{title}" }, class: 'link-edit'
  end

  def flash_message_type(message_type)
    message_type = 'danger' if message_type == 'error'
    message_type
  end

  def format_date(date)
    date.strftime("%d/%m/%Y") if date.present?
  end

  def include_unobtrusive_js
    @unobtrusive_js ||= []
    javascript_tag(@unobtrusive_js.join(";\n"))
  end

  def show_link(path)
    link_to ('<i class="fa fa-eye"></i>').html_safe, path, class: 'btn-show'
  end

  def unobtrusive_js(code)
    if request.xhr?
      javascript_tag(code)
    else
      @unobtrusive_js ||= []
      @unobtrusive_js << code
      nil
    end
  end
end
