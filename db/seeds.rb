User.create!(name:"kaminoyama", email:"sample@gmail.com", password: "123456", password_confirmation: "123456", admin: true)
Task.create!(title: "タイトル", content: "内容", deadline: "2022-12-01", status: "未着手", priority: "高", user_id: 1)
Label.create!(name: "fist_label")

10.times do |i|
  # name = Faker::Games::Pokemon.name
  # email = Faker::Internet.email
  # password = "password"
  User.create!(name: "User#{i+1}", email:  "sample#{i+1}@gmail.com", password:"111111#{i+1}", password_confirmation: "111111#{i+1}", admin: false)
end

10.times do |i|
  Task.create!(title: "Task#{i+1}", content: "Task#{i+1}", deadline: "2022-12-01", status: "未着手", priority: "高", user_id: 1)
end

10.times do |i|
  Label.create!(name: "Lbel#{i+1}")
end


