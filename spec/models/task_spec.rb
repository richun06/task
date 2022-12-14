# bundle exec rspec ./spec/models/task_spec.rb
require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }
  before do
    @current_user = User.find_by(email: "test_taro@sample.com")
  end
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.create(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
      context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功', content: 'テスト', user_id: @current_user.id)
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task', user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, title: "sample", user: user) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.title_search('task')).to include(task)
        expect(Task.title_search('task')).not_to include(second_task)
        expect(Task.title_search('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_search('完了')).to include(task)
        expect(Task.status_search('完了')).not_to include(second_task)
        expect(Task.status_search('完了').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.title_search('task').status_search('完了')).to include(task)
        expect(Task.title_search('task').status_search('完了')).not_to include(second_task)
        expect(Task.title_search('task').status_search('完了').count).to eq 1
      end
    end
  end
end