# bundle exec rspec spec/system/task_spec.rb
require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let!(:task) {FactoryBot.create(:task,user: user) }
  let!(:second_task){ FactoryBot.create(:second_task,user: user) }
  let!(:third_task){FactoryBot.create(:third_task,user: user) }
  before do
    visit new_session_path
    fill_in 'session[email]', with: 'test_taro@sample.com'
    fill_in 'session[password]', with: '111111'
    click_on 'Log in'
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: "テストタスク"
        fill_in 'task[content]', with: "お腹すいた"
        # select "2022-11-5", from: "task_deadline"
        # fill_in 'task[deadline]', with: "2022-11-4"
        # fill_in 'task[status]', with: "未着手"
        # fill_in 'task[priority]', with: ""
        click_on "作成"
        expect(page).to have_content 'テストタスク'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'test_title'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(page).to have_content 'test_title3'
      end
    end
    context '終了期限でソートした場合' do
      it '終了期限の降順に一覧に表示される' do
        visit tasks_path
        click_on "終了期限でソートする"
        sleep(1)
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content '2022-11-06'
      end
    end
    context '優先順位でソートした場合' do
      it '優先順位の昇順に一覧に表示される' do
        visit tasks_path
        click_on "優先順位でソートする"
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content '3'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit tasks_path(task.id)
        expect(page).to have_content 'test_content2'
      end
    end
  end

  describe '検索機能' do
    before do
      FactoryBot.create(:task, title: "task", user: user)
      FactoryBot.create(:second_task, title: "sample", user: user)
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in "search_title", with: "ta"
        click_on "検索"
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select "完了", from: "search_status"
        click_on "検索"
        expect(page).to have_content '完了'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in "search_title", with: "t"
        select "完了", from: "search_status"
        click_on "検索"
        expect(page).to have_content 'test'
      end
    end
  end
end