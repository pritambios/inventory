module ItemsHelper
  def working_status(item)
    item.working ? 'Working' : 'Non Working'
  end
end
