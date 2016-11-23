module ItemsHelper
  def working_status(item)
    item.working ? 'Working' : 'Non Working'
  end

  def name_with_id(item)
    "#{item.name} #{item.id}"
  end
end
