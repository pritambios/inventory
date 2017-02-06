class Item < ActiveRecord::Base
  around_save :update_item_history

  has_many :checkouts
  has_many :documents, inverse_of: :item
  has_many :issues
  has_many :item_histories
  has_many :childrens, class_name: "Item", foreign_key: "parent_id"

  belongs_to :employee
  belongs_to :brand
  belongs_to :category
  belongs_to :parent, class_name: "Item", foreign_key: "parent_id"
  belongs_to :vendor

  validates :category, presence: true

  accepts_nested_attributes_for :documents, reject_if: :all_blank, allow_destroy: true

  scope :active,          -> { joins(:category).where(discarded_at: nil, categories: { deleted_at: nil }) }
  scope :available,       -> { where.not(id: unavailable) }
  scope :not_erased,      -> { where(deleted_at: nil) }
  scope :order_desending, -> { order('created_at DESC') }
  scope :unattached,      -> { where(parent_id: nil, employee_id: nil) }
  scope :unavailable,     -> { joins(:checkouts).where(checkouts: { check_in: nil }) }
  scope :parent_list,     -> { where(parent_id: nil) }

  def self.unassociated_items(item)
    where.not(id: item.childrens.pluck(:id,item.id))
  end

  def change_parent(parent)
    if parent.present? && self != parent

      unless self.childrens.include?(parent)
        self.update_attributes(parent_id: parent.id)
      end
    end
  end

  def add_child(child)
    if child.present? && self != child

      unless child.id == self.parent_id
        @update_child = child.update_attributes(parent_id: self.id)
      end
    end
  end

  def name
    "#{brand.try(:name)} #{category.name}"
  end

  def name_with_id
    "#{name} #{id}"
  end

  def pending_checkout
    checkouts.pending.order_desending.first
  end

  def reallocate(employee)
    self.employee_id = employee
    save
  end

  def unavailable?
    checkouts.map(&:checkin?).include? false
  end

  def discard(reason)
    update_attributes(system_id: nil, working: false, discarded_at: Time.now, employee_id: nil, discard_reason: reason)
  end

  private

  def update_item_history
    if employee_id_changed? || working_changed? || new_record? || parent_id_changed?
      item_history = item_histories.build(employee_id: employee_id,  status: working, parent_id: parent_id)
    end

    yield

    item_history.save if item_history.present?
  end
end
