require 'rails_helper'
RSpec.describe 'ユーザモデル機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }
  # before do
  #   @current_user = User.find_by(email: "test_taro@sample.com")
  # end
  describe 'バリデーションのテスト' do
    context 'ユーザの名前が空の場合' do
      it 'バリデーションにひっかる' do
        user = User.create(name: '', email:'model_test@sample.com', password: '111111', password_confirmation: '111111', admin: false)
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレスの名前が空の場合' do
      it 'バリデーションにひっかる' do
        user = User.create(name: 'モデルテスト', email:'', password: '111111', password_confirmation: '111111', admin: false)
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレスの名前が正しくない場合' do
      it 'バリデーションにひっかる' do
        user = User.create(name: 'モデルテスト', email:'model_test', password: '111111', password_confirmation: '111111', admin: false)
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレスがすでに使われていた場合' do
      it 'バリデーションにひっかる' do
        user = User.create(name: 'モデルテスト', email:'test_taro@sample.com', password: '111111', password_confirmation: '111111', admin: false)
        expect(user).not_to be_valid
      end
    end
    context 'パスワードが空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.create(name: 'モデル', email:'model@sample.com', password: '', password_confirmation: '', admin: false)
        expect(user).not_to be_valid
      end
    end
    context 'パスワードが6文字以下だった場合' do
      it 'バリデーションにひっかかる' do
        user = User.create(name: 'モデル', email:'model@sample.com', password: '11111', password_confirmation: '111111', admin: false)
        expect(user).not_to be_valid
      end
    end
    context 'ユーザの登録内容に全て正しく入力されている場合' do
      it 'バリデーションが通る' do
        user = User.new(name: 'モデル', email:'model@sample.com', password: '111111', password_confirmation: '111111', admin: false)
        expect(user).to be_valid
      end
    end
  end
end