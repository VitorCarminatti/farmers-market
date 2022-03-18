require "rails_helper"

RSpec.describe PagesController, type: :controller do
  let!(:product1) { Product.create(code: 'CH1', name: 'Chai', price: 3.11) }
  let!(:product2) { Product.create(code: 'AP1', name: 'Apples', price: 6.00) }
  let!(:product3) { Product.create(code: 'CF1', name: 'Coffee', price: 11.23) }
  let!(:product4) { Product.create(code: 'MK1', name: 'Milk', price: 4.75) }

  context 'totalize_products' do
    let(:valid_params_case_1) do
      {"items"=>"{\"CH1\":1,\"MK1\":1,\"AP1\":1,\"CF1\":2}"}
    end

    let(:valid_params_case_2) do
      {"items"=>"{\"AP1\":1,\"MK1\":1}"}
    end

    let(:valid_params_case_3) do
      {"items"=>"{\"CF1\":2}"}
    end

    let(:valid_params_case_4) do
      {"items"=>"{\"AP1\":3,\"CH1\":1,\"MK1\":1}"}
    end

    describe 'should return the correct total' do
      it 'case 1' do
        post :totalize_products, params: valid_params_case_1
        expect(JSON.parse(response.body)['total']).to eq('20.34')
      end
      it 'case 2' do
        post :totalize_products, params: valid_params_case_2
        expect(JSON.parse(response.body)['total']).to eq('10.75')
      end
      it 'case 3' do
        post :totalize_products, params: valid_params_case_3
        expect(JSON.parse(response.body)['total']).to eq('11.23')
      end
      it 'case 4' do
        post :totalize_products, params: valid_params_case_4
        expect(JSON.parse(response.body)['total']).to eq('16.61')
      end
    end
  end
end
