require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  render_views
  let(:items) { create_list :item, 5 }
  let(:item) { create :item }
  let(:items_params) do
    {
      item: {
        name: 'car',
        price: 50,
        description: 'black'
      }
    }
  end

  context 'GET #index' do
    before { get :index }

    it 'returns items' do
      is_expected.to render_template :index
      expect(assigns(:items)).to match_array(items)
    end
  end

  context 'POST #create' do
    subject { post :create, params: items_params }

    it 'save the item' do
      expect { subject }.to change(Item, :count).by 1
    end

    it 'redirect_to index' do
      expect(subject).to redirect_to action: :index
    end

    context 'with invalid params' do
      let(:items_params) do
        { item: { price: -20 } }
      end
      it 'dosnt save' do
        expect { subject }.to_not change(Item, :count)
        is_expected.to render_template :new
      end
    end
  end

  context 'DESTOROY #destroy' do
    subject { delete :destroy, params: params }
    let(:params) {{ id: item.id } }
    it 'delete from item' do
      item.reload
      expect { subject }.to change(Item, :count).by(-1)
    end

    it 'redirect new template' do
      is_expected.to redirect_to action: :index
    end
  end

  context 'GET #show' do
    let(:params) { { id: item.id } }
    before { get :show, params: params }
    it 'show item' do
      is_expected.to render_template :show
      expect(assigns(:item)).eql? item
    end
  end

end