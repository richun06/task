User.create!(name:"kaminoyama", email:"sample@gmail.com", password: "123456", password_confirmation: "123456", admin: true)
Task.create!(title: "タイトル", content: "内容", deadline: "2022-12-01", status: "未着手", priority: "高", user_id: 1)
Label.create!(name: "fist_label")