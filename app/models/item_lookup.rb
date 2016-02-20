class ItemLookup
  attr_accessor :client, :item

  def initialize(sku)
    @client = ASIN::Client.instance
    @item = client.lookup(sku)
    @item = @item.first
  end

  def detail_page_url
    PostRank::URI.clean(item["detail_page_url"])
  end

  def review_url
    item["item_links"]["item_link"].each do |object|
      if object.description == "All Customer Reviews"
        return PostRank::URI.clean(object.url)
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
      features = item["item_attributes"]["feature"]
      if features.class == Array
        features
      else
        [features]
      end
    end
  end

  def current_price
    lowest_new_price = item["offer_summary"]["lowest_new_price"] || item["item_attributes"]["list_price"]["formatted_price"]
    return "$00.00" unless lowest_new_price.present?
    if lowest_new_price.include?("amount")
      lowest_new_price["amount"]
    end
  end

  def large_image_url
    image_checker("large_image")
  end

  def small_image_url
    image_checker("small_image")
  end

  def medium_image_url
    image_checker("medium_image")
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

  private

  def image_checker(image_string)
    if item.include?(image_string)
      item[image_string]["url"]
    else
      item["image_sets"]["image_set"].first[image_string]["url"]
    end
  end
end