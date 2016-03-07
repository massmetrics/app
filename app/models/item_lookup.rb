class ItemLookup
  attr_accessor :client, :items

  def initialize(sku_array)
    @client = ASIN::Client.instance
    get_items(sku_array)
  end

  def get_items(sku_array)
    tries = 0
    while @items.nil?
      begin
        items = client.lookup(sku_array)
        @items = items.map { |item| hashify(item) }
      rescue => e
        puts "Error is #{e.message}, #{e.backtrace}"
        tries += 1
        retry unless tries >= 20
      end
    end
  end

  def hashify(item)
    begin
      price = current_price(item) || AmazonScraper.new(detail_page_url(item)).price
      {
        features: features(item),
        sku: item.asin,
        detail_page_url: detail_page_url(item),
        review_url: review_url(item),
        title: title(item).truncate(254),
        current_price: NumberFormatter.format_price_string(price),
        large_image_url: large_image_url(item),
        medium_image_url: medium_image_url(item),
        small_image_url: small_image_url(item),
        brand: brand(item)
      }
    rescue => e
      puts "SKU: #{item.sku} failed to update due to #{e.message}"
      puts e.backtrace
    end
  end


  def detail_page_url(item)
    PostRank::URI.clean(item["detail_page_url"])
  end

  def review_url(item)
    item["item_links"]["item_link"].each do |object|
      if object.description == "All Customer Reviews"
        return PostRank::URI.clean(object.url)
      end
    end
  end

  def title(item)
    if item["item_attributes"].include?("title")
      item["item_attributes"]["title"]
    end
  end

  def features(item)
    if item["item_attributes"].include?("feature")
      features = item["item_attributes"]["feature"]
      features.is_a?(Array) ? features : [features]
    end
  end

  def current_price(item)
    lowest_new_price = nil
    return nil unless item.present?
    if item["offer_summary"] && item["offer_summary"]["lowest_new_price"]
      lowest_new_price = item["offer_summary"]["lowest_new_price"]
    elsif item["item_attributes"] && item["item_attributes"]["list_price"] && item["item_attributes"]["list_price"]["formatted_price"]
      lowest_new_price = item["item_attributes"]["list_price"]["formatted_price"]
    end
    return nil unless lowest_new_price.present?
    if lowest_new_price.include?("amount")
      lowest_new_price["amount"]
    end
  end

  def large_image_url(item)
    image_checker(item, "large_image")
  end

  def small_image_url(item)
    image_checker(item, "small_image")
  end

  def medium_image_url(item)
    image_checker(item, "medium_image")
  end

  def brand(item)
    if item["item_attributes"].include?("brand")
      item["item_attributes"]["brand"]
    end
  end

  private

  def image_checker(item, image_string)
    if item.include?(image_string)
      item[image_string]["url"]
    else
      item["image_sets"]["image_set"].first[image_string]["url"]
    end
  end
end
