FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    deadline { "2022-11-04" }
    status { '完了' }
    priority { '低' }
    user_id { '1' }
  end
  factory :second_task, class: Task do
    title { 'test_title2' }
    content { 'test_content2' }
    status { '未着手' }
    deadline { "2022-11-05" }
    priority { '高' }

  end
  factory :third_task, class: Task do
    title { 'test_title3' }
    content { 'test_content3' }
    deadline { "2022-11-06" }
    priority { '中' }
  end
  factory :fourth_task, class: Task do
    title { 'test_title4' }
    content { 'test_content4' }
    priority { '高' }
  end
end