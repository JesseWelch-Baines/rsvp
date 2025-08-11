module ListItemsHelper
  def item_list_links(item)
    case item.class.to_s
    when "Guest"
      {
        show_path: guest_path(item),
        edit_path: edit_guest_path(item),
      }
    else
      {}
    end
  end
end
