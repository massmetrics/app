class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # check_authorization

  def meta_tag_setter(title, description, keywords, reverse)
    set_meta_tags({title: title, description: description, keywords: keywords, reverse: reverse})
  end

  def key_words
    "best, health, fitness, supplements, cheap, cheapest, protein, health supplements, protein powder, diet, exercise, discount "
  end
end
