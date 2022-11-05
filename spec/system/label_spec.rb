require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let!(:task) {FactoryBot.create(:task,user: user) }
  let!(:label) {FactoryBot.create(:label) }
  before do
    visit new_session_path
    fill_in 'session[email]', with: 'test_taro@sample.com'
    fill_in 'session[password]', with: '111111'
    click_on 'Log in'
  end

  describe 'ラベル作成機能' do
    context 'タスクを新規作成した場合ラベルも登録できる' do
      it 'タスク一覧画面で登録したラベルが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: "テストタスク"
        fill_in 'task[content]', with: "お腹すいた"
        # select "2022-11-5", from: "task_deadline"
        # fill_in 'task[deadline]', with: "2022-11-4"
        # fill_in 'task[status]', with: "未着手"
        # fill_in 'task[priority]', with: ""
        check "test_label"
        click_on "作成"
        expect(page).to have_content 'test_label'
      end
    end
  end

  describe 'ラベル検索機能' do
    context 'つけたラベルで検索することができる' do
      it '検索したラベルに紐づいたタスクを表示される' do
        visit new_task_path
        fill_in 'task[title]', with: "テストタスク"
        fill_in 'task[content]', with: "お腹すいた"
        # select "2022-11-5", from: "task_deadline"
        # fill_in 'task[deadline]', with: "2022-11-4"
        # fill_in 'task[status]', with: "未着手"
        # fill_in 'task[priority]', with: ""
        check "test_label"
        click_on "作成"
        visit tasks_path
        select "test_label", from:"label_id"
        click_on "ラベル検索"
        expect(page).to have_content 'test_label'
      end
    end
  end

end