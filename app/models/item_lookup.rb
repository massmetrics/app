class ItemLookup
  attr_accessor :client, :item
  def initialize(sku)
    @client = ASIN::Client.instance
    @item = client.lookup(sku)
  end

  def detail_page_url
    item.first["detail_page_url"]
  end

  def review_url
    item.first["item_links"]["item_link"].each do |object|
      if object.description == "All Customer Reviews"
        return object.url
      end
    end
  end

  def title
    item.first["item_attributes"]["title"]
  end

  def features
    item.first["item_attributes"]["feature"]
  end

  def current_price
    item.first["offer_summary"]["lowest_new_price"]["amount"]
  end

  def large_image_url
    item.first["image_sets"]["image_set"].first["large_image"]["url"]
  end

  def small_image_url
    item.first["image_sets"]["image_set"].first["small_image"]["url"]
  end

  def medium_image_url
    item.first["image_sets"]["image_set"].first["medium_image"]["url"]
  end

  def brand
    item.first["item_attributes"]["brand"]
  end
end