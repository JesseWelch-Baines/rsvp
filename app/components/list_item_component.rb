class ListItemComponent < ViewComponent::Base
  def initialize(item:, index:, count:, links:, name: nil)
    @item = item
    @name = name
    @index = index
    @count = count
    @links = links
  end
end
