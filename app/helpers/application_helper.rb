module ApplicationHelper
  def back_link
    link_to ('<i class="fa fa-arrow-left"></i> Back').html_safe, :back
  end

  def edit_link(path)
    link_to ('<i class="fa fa-edit" title="Edit Details"></i> Edit').html_safe, path, class: 'btn btn-sm btn-edit'
  end

  def show_link(path)
    link_to ('<i class="fa fa-eye"></i>').html_safe, path, class: 'btn-show'
  end

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end
end
