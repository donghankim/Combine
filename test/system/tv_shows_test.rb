require "application_system_test_case"

class TvShowsTest < ApplicationSystemTestCase
  setup do
    @tv_show = tv_shows(:one)
  end

  test "visiting the index" do
    visit tv_shows_url
    assert_selector "h1", text: "Tv Shows"
  end

  test "creating a Tv show" do
    visit tv_shows_url
    click_on "New Tv Show"

    fill_in "Director", with: @tv_show.director
    fill_in "Genre", with: @tv_show.genre
    fill_in "Name", with: @tv_show.name
    fill_in "Rating", with: @tv_show.rating
    fill_in "Seasons", with: @tv_show.seasons
    fill_in "Show stars", with: @tv_show.show_stars
    fill_in "User", with: @tv_show.user_id
    click_on "Create Tv show"

    assert_text "Tv show was successfully created"
    click_on "Back"
  end

  test "updating a Tv show" do
    visit tv_shows_url
    click_on "Edit", match: :first

    fill_in "Director", with: @tv_show.director
    fill_in "Genre", with: @tv_show.genre
    fill_in "Name", with: @tv_show.name
    fill_in "Rating", with: @tv_show.rating
    fill_in "Seasons", with: @tv_show.seasons
    fill_in "Show stars", with: @tv_show.show_stars
    fill_in "User", with: @tv_show.user_id
    click_on "Update Tv show"

    assert_text "Tv show was successfully updated"
    click_on "Back"
  end

  test "destroying a Tv show" do
    visit tv_shows_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tv show was successfully destroyed"
  end
end
