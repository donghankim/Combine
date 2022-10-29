require "test_helper"

class TvShowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tv_show = tv_shows(:one)
  end

  test "should get index" do
    get tv_shows_url
    assert_response :success
  end

  test "should get new" do
    get new_tv_show_url
    assert_response :success
  end

  test "should create tv_show" do
    assert_difference('TvShow.count') do
      post tv_shows_url, params: { tv_show: { director: @tv_show.director, genre: @tv_show.genre, name: @tv_show.name, rating: @tv_show.rating, seasons: @tv_show.seasons, show_stars: @tv_show.show_stars, user_id: @tv_show.user_id } }
    end

    assert_redirected_to tv_show_url(TvShow.last)
  end

  test "should show tv_show" do
    get tv_show_url(@tv_show)
    assert_response :success
  end

  test "should get edit" do
    get edit_tv_show_url(@tv_show)
    assert_response :success
  end

  test "should update tv_show" do
    patch tv_show_url(@tv_show), params: { tv_show: { director: @tv_show.director, genre: @tv_show.genre, name: @tv_show.name, rating: @tv_show.rating, seasons: @tv_show.seasons, show_stars: @tv_show.show_stars, user_id: @tv_show.user_id } }
    assert_redirected_to tv_show_url(@tv_show)
  end

  test "should destroy tv_show" do
    assert_difference('TvShow.count', -1) do
      delete tv_show_url(@tv_show)
    end

    assert_redirected_to tv_shows_url
  end
end
