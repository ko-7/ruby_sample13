# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
    email: "example@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar",
    admin:     true,
    activated: true,
    activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
content = Faker::Lorem.sentence(word_count: 50)
User.create!(name:  name,
     email: email,
     password:              password,
     password_confirmation: password,
     content: content,
     activated: true,
     activated_at: Time.zone.now)
end

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# 以下のリレーションシップを作成する
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# ユーザーの一部を対象にイベント投稿を作成する
users = User.order(:created_at).take(6)
3.times do
  maintitle = Faker::Lorem.sentence(word_count: 7)
  users.each { |user| user.events.create!(maintitle: maintitle)}
end

# 「コラボ申請」の関係を作成する
users = User.all
user = users.first
target_users = users[5..7]
applicant_users = users[2..10]
target_users.each { |target_user| user.apply(target_user) }
applicant_users.each { |applicant_user| applicant_user.apply(user) }


