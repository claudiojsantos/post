# spec/concerns/paginatable_spec.rb

require 'rails_helper'

RSpec.describe Paginatable do
  let(:mock_model) { double(count: 10) }

  class DummyController < ActionController::Base
    include Paginatable

    attr_accessor :params, :model

    def initialize(params = {}, model)
      @params = params
      @model = model
    end

    def self.before_action(*); end

    def paginatable_model
      model
    end
  end

  let(:controller) { DummyController.new({}, mock_model) }

  describe '#check_page_range' do
    context 'when page is within range' do
      it 'does not modify the page param' do
        controller.params = { page: '1' }
        controller.send(:check_page_range)
        expect(controller.params[:page]).to eq('1')
      end
    end

    context 'when page is out of range' do
      it 'updates the page param to the last page' do
        controller.params = { page: '5' }
        controller.send(:check_page_range)
        expect(controller.params[:page]).to eq(2)
      end
    end
  end

  describe '#total_pages_for' do
    it 'calculates total pages' do
      model = double(count: 10)
      expect(controller.send(:total_pages_for, model)).to eq(2)
    end
  end
end
