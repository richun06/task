require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        task = FactoryBot.create(:second_task)
        visit tasks_path
        expect(page).to have_content 'test_content2'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        task_list = all('.task_row')
        expect(page).to have_content 'task'
      end
    end

    context '終了期限でソートした場合' do
      it '終了期限の降順に一覧に表示される' do
        task = FactoryBot.create(:third_task, deadline: "2022-09-01")
        visit tasks_path
        click_on "終了期限でソートする"
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content '2022-09-01'

      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:second_task)
        visit tasks_path(task.id)
        expect(page).to have_content 'test_content2'
      end
    end
  end
end