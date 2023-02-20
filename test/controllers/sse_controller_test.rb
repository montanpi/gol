require 'test_helper'

class SseControllerTest < ActionDispatch::IntegrationTest
  test 'should get start' do
    get sse_start_url
    assert_response :success
  end
end
