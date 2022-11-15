require 'rails_helper'

RSpec.describe "friends/index", type: :view do
  before(:each) do
    assign(:friends, [
      Friend.create!(
        name: 2,
        user_id: 3
      ),
      Friend.create!(
        name: 2,
        user_id: 3
      )
    ])
  end

  it "renders a list of friends" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
