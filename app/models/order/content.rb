class Order
  module Content
    def add(variant, quantity = 1, options = {})
      add_to_line_item(variant, quantity, options)
      update_totals
    end

    def remove(line_item_id)
      line_items.destroy(line_item_id)
      update_totals
    end

    def update_cart(params)
      if update_attributes(filter_order_items(params))
        update_totals
        true
      else
        false
      end
    end

    def empty!
      line_items.delete_all
      update_totals
    end

    private
    def add_to_line_item(variant, quantity, options = {})
      line_item = line_items.find_by(variant_id: variant.id)
      if line_item
        line_item.quantity += quantity.to_i
        # 使用此时 variant 的价格作为新价格
        line_item.price = variant.price
      else
        line_item = line_items.new(quantity: quantity,
                                    variant: variant,
                                      price: variant.price)
      end
      line_item.save!
      line_item
    end

    def filter_order_items(params)
      return params if params[:line_items_attributes].nil?
      line_item_ids = line_items.pluck(:id)
      params[:line_items_attributes].each do |value|
        unless line_item_ids.include?(value[:id].to_i) || value[:variant_id].present?
          params[:line_items_attributes].delete_if { |item| item[:id] == value[:id]}
        end
        # 数量小于 0 则删除 line_items
        unless value[:quantity] > 0
          value[:_destroy] = true
        end
      end
      params
    end
  end
end
