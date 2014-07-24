class ItemLookup
  attr_accessor :client, :item

  def initialize(sku)
    @client = ASIN::Client.instance
    @item = client.lookup(sku)
    @item = @item.first
  end

  def detail_page_url
    item["detail_page_url"]
  end

  def review_url
    item["item_links"]["item_link"].each do |object|
      if object.description == "All Customer Reviews"
        return object.url
      end
    end
  end

  def title
    if item["item_attributes"].include?("title")
      item["item_attributes"]["title"]
    end
  end

  def features
    if item["item_attributes"].include?("feature")
      item["item_attributes"]["feature"]
    end
  end

  def current_price
    lowest_new_price = item["offer_summary"]["lowest_new_price"]
    if lowest_new_price.include?("amount")
      lowest_new_price["amount"]
    end
  end

  def large_image_url
    if item.include?("large_image")
      item["large_image"]["url"]
    else
      item["image_sets"]["image_set"].first["large_image"]["url"]
    end
  end

  def small_image_url
    if item.include?("small_image")
      item["small_image"]["url"]
    else
      item["image_sets"]["image_set"].first["small_image"]["url"]
    end
  end

  def medium_image_url
    if item.include?("medium_image")
      item["medium_image"]["url"]
    else
      item["image_sets"]["image_set"].first["medium_image"]["url"]
    end
  end

  def brand
    if item["item_attributes"].include?("brand")
      item["item_attributes"]["brand"]
    end
  end

  def to_hash
    current_price = AmazonScraper.new(detail_page_url).price || self.current_price
    {
      features: features,
      detail_page_url: detail_page_url,
      review_url: review_url,
      title: title,
      current_price: NumberFormatter.format_price_string(current_price),
      large_image_url: large_image_url,
      medium_image_url: medium_image_url,
      small_image_url: small_image_url,
      brand: brand
    }
  end
end