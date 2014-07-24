class SubmissionHelper
  class << self
    def split_categories(category_string)
      category_string.split(",").map(&:strip)
    end
  end
end