require 'rails_helper'

describe Category do
  it "returns a list of all categories" do
    Category.create(category: "Protein")
    Category.create(category: "Pre workout")
    Category.create(category: "Pre workout")

    expect(Category.category_list).to match_array(["Protein", "Pre workout"])
  end


end