require 'rails_helper'

RSpec.describe "friends/edit", type: :view do
  let(:friend) {
    Friend.create!(
      name: 1,
      user_id: 1
    )
  }

  before(:each) do
    assign(:friend, friend)
  end

  it "renders the edit friend form" do
    render

    assert_select "form[action=?][method=?]", friend_path(friend), "post" do

      assert_select "input[name=?]", "friend[name]"

      assert_select "input[name=?]", "friend[user_id]"
    end
  end
end
