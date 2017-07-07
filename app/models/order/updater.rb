module Order::Updater
  def update_totals
    update_item_count
    update_item_total
    update_order_total
    persist_totals
  end

  private

  def update_item_count
    self.item_count = line_items.sum(:quantity)
  end

  def update_item_total
    self.item_total = line_items.sum('price * quantity')
  end

  def update_order_total
    order_total = item_total
    self.total = order_total > 0 ? order_total : 0
  end

  def persist_totals
    update_columns(
      item_total: item_total,
      item_count: item_count,
      total: total,
      updated_at: Time.now
    )
  end
end
