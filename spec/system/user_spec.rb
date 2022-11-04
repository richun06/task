require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe 'ユーザの新規登録ができること' do
    context 'ユーザを新規登録した場合' do
      it '作成したユーザが表示される' do
        user = FactoryBot.create(:user)
        visit new_user_path
        fill_in "user[name]", with: "テストユーザ"
        fill_in "user[email]", with: "test_user@sample.com"
        fill_in "user[password]", with: "111111"
        fill_in "user[password_confirmation]", with: "111111"
        click_on "Create my account"
        expect(page).to have_content "テストユーザ"
        expect(page).to have_content "test_user@sample.com"
      end
    end
  end

  describe 'ユーザがログインせずにタスク一覧に飛ぼうとした時、ログイン画面に遷移すること' do
    context 'ログインしてないユーザがタスク一覧に飛ぼうとした場合' do
      it 'ログイン画面が表示される' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    before do
      visit new_session_path
      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: user.password
      click_on "commit"
    end
    describe 'ログインができること' do
      context '既存ユーザがログインした場合' do
        it 'ログインでき、マイページに飛ぶ' do
          expect(page).to have_content 'テスト太郎'
        end
      end
    end
    describe 'マイページに飛べること' do
      context 'ログイン済みのユーザの場合' do
        it 'マイページに飛ぶ' do
          visit tasks_path
          click_on 'Profile'
          expect(current_path).to eq user_path(user)
        end
      end
    end
    describe '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
      context '他人の詳細画面に飛ぼうとすると' do
        it 'タスク一覧画面に遷移する' do
          click_on "Logout"
          fill_in 'session[email]', with: second_user.email
          fill_in 'session[password]', with: second_user.password
          click_on 'Log in'
          visit user_path(user)
          expect(current_path).to eq tasks_path
        end
      end
    end
    describe 'ログアウトができること' do
      context 'ログイン済みのユーザがログアウトしたい場合' do
        it 'ログアウトができる' do
          click_on 'Logout'
          expect(current_path).to eq new_session_path
        end
      end
    end
  end

  describe 'セッション機能のテスト' do
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    before do
      visit new_session_path
      fill_in "session[email]", with: admin_user.email
      fill_in "session[password]", with: admin_user.password
      click_on "Log in"
    end
    describe '管理ユーザは管理画面にアクセスできること' do
      context 'ログインユーザが管理者だった場合' do
        it '管理画面にアクセスできる' do
          visit admin_users_path
          expect(current_path).to eq admin_users_path
        end
      end
    end
    describe '一般ユーザは管理画面にアクセスできないこと' do
      context 'ログインユーザが一般ユーザだった場合' do
        it '管理画面にアクセスできない' do
          visit new_session_path
          fill_in 'session[email]', with: second_user.email
          fill_in 'session[password]', with: second_user.password
          click_on "Log in"
          visit admin_users_path
          expect(page).to have_content '管理者以外はアクセスできない'
        end
      end
    end
    describe '管理ユーザはユーザの新規登録ができること' do
      context 'ログインユーザが管理者だった場合' do
        it 'ユーザの新規登録ができる' do
          visit new_admin_user_path
          fill_in 'user[name]', with: 'ヨルさん'
          fill_in 'user[email]', with: 'yoru@sample.com'
          fill_in 'user[password]', with: '333333'
          fill_in 'user[password_confirmation]', with: '333333'
          click_on 'Create accoun'
          expect(page).to have_content "ヨルさん"
        end
      end
    end
    describe '管理ユーザはユーザの詳細画面にアクセスできること' do
      context 'ログインユーザが管理者だった場合' do
        it 'ユーザの詳細画面にアクセスできる' do
          visit admin_user_path(second_user)
          expect(current_path).to include admin_user_path(second_user)
        end
      end
    end
    describe '管理ユーザはユーザの編集画面からユーザを編集できること' do
      context 'ログインユーザが管理者だった場合' do
        it '編集画面からユーザを編集できる' do
          visit edit_admin_user_path(second_user)
          fill_in 'user[name]', with: '花子'
          fill_in 'user[email]', with: 'test_hanako@sample.com'
          # fill_in 'user[password]', with: '111111'
          # fill_in 'user[password_cofirmation]', with: '111111'
          click_on "Update"
          expect(page).to have_content '花子'
        end
      end
    end
    describe '管理ユーザはユーザの削除をできること' do
      context 'ログインユーザが管理者だった場合' do
        it 'ユーザの削除ができる' do
          visit admin_users_path
          click_on "削除", match: :first
          expect(current_path).to eq admin_users_path
        end
      end
    end
  end

end