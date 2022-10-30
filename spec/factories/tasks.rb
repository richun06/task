FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    status { '完了' }
  end
  factory :second_task, class: Task do
    title { 'test_title2' }
    content { 'test_content2' }
    status { '未着手' }
  end
  factory :third_task, class: Task do
    title { 'test_title3' }
    content { 'test_content3' }
    deadline { Date.time }
  end
  factory :fourth_task, class: Task do
    title { 'test_title4' }
    content { 'test_content4' }
    priority { '高' }
  end
end