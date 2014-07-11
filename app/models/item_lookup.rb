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
    if item.first["item_attributes"].include?("title")
      item.first["item_attributes"]["title"]
    end
  end

  def features
    if item.first["item_attributes"].include?("feature")
      item.first["item_attributes"]["feature"]
    end
  end

  def current_price
    if item.first["item_attributes"]["list_price"].include?("amount")
      item.first["item_attributes"]["list_price"]["amount"]
    end
  end

  def large_image_url
    if item.first.include?("large_image")
      item.first["large_image"]["url"]
    end
  end

  def small_image_url
    if item.first.include?("small_image")
      item.first["small_image"]["url"]
    end
  end

  def medium_image_url
    if item.first.include?("medium_image")
      item.first["medium_image"]["url"]
    end
  end

  def brand
    if item.first["item_attributes"].include?("brand")
      item.first["item_attributes"]["brand"]
    end
  end

  def description
    if item.first["editorial_reviews"]["editorial_review"].include?("content")
      item.first["editorial_reviews"]["editorial_review"]["content"]
    end
  end
end