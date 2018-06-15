module ApplicationHelper
  def back_link
    link_to content_tag(:i, t('button.back'), class: 'fa fa-arrow-left'), :back
  end

  def delete_link(path)
    link_to content_tag(:i, t('button.delete.name'), title: t('button.delete.title'), class: 'fa fa-trash'),
            path, method: :delete, data: { confirm: t('button.delete.confirm_message') }, class: 'btn btn-danger btn-sm'
  end

  def edit_link(path, title = t('button.edit.title'))
    link_to content_tag(:i, t('button.edit.name'), title: t('button.edit.button_title'), class: 'fa fa-edit'),
            path, data: { remote_popup: true, title: "#{t('button.edit.popup_title')} #{title}" }, class: 'link-edit'
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
    link_to content_tag(:i, '', class: 'fa fa-eye'), path, class: 'btn-show'
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
