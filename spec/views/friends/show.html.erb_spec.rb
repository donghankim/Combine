require 'rails_helper'

RSpec.describe "friends/show", type: :view do
  before(:each) do
    assign(:friend, Friend.create!(
      name: 2,
      user_id: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
