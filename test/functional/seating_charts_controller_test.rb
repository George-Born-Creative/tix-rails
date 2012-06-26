require 'test_helper'

class SeatingChartsControllerTest < ActionController::TestCase
  setup do
    @seating_chart = seating_charts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seating_charts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seating_chart" do
    assert_difference('SeatingChart.count') do
      post :create, seating_chart: {  }
    end

    assert_redirected_to seating_chart_path(assigns(:seating_chart))
  end

  test "should show seating_chart" do
    get :show, id: @seating_chart
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @seating_chart
    assert_response :success
  end

  test "should update seating_chart" do
    put :update, id: @seating_chart, seating_chart: {  }
    assert_redirected_to seating_chart_path(assigns(:seating_chart))
  end

  test "should destroy seating_chart" do
    assert_difference('SeatingChart.count', -1) do
      delete :destroy, id: @seating_chart
    end

    assert_redirected_to seating_charts_path
  end
end
