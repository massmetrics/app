require 'rails_helper'
describe SubmissionHelper do
  it "formats a comma delimited string into an array" do
    categories = "Protein, Pre Workout"

    expect(SubmissionHelper.split_categories(categories)).to eq(['Protein', 'Pre Workout'])
  end
end