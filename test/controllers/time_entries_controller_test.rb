require "test_helper"

class TimeEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get start" do
    get time_entries_start_url
    assert_response :success
  end

  test "should get stop" do
    get time_entries_stop_url
    assert_response :success
  end
end
