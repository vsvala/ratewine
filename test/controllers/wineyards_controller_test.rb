# frozen_string_literal: true

require 'test_helper'

class WineyardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wineyard = wineyards(:one)
  end

  test 'should get index' do
    get wineyards_url
    assert_response :success
  end

  test 'should get new' do
    get new_wineyard_url
    assert_response :success
  end

  test 'should create wineyard' do
    assert_difference('Wineyard.count') do
      post wineyards_url, params: { wineyard: { name: @wineyard.name, year: @wineyard.year } }
    end

    assert_redirected_to wineyard_url(Wineyard.last)
  end

  test 'should show wineyard' do
    get wineyard_url(@wineyard)
    assert_response :success
  end

  test 'should get edit' do
    get edit_wineyard_url(@wineyard)
    assert_response :success
  end

  test 'should update wineyard' do
    patch wineyard_url(@wineyard), params: { wineyard: { name: @wineyard.name, year: @wineyard.year } }
    assert_redirected_to wineyard_url(@wineyard)
  end

  test 'should destroy wineyard' do
    assert_difference('Wineyard.count', -1) do
      delete wineyard_url(@wineyard)
    end

    assert_redirected_to wineyards_url
  end
end
