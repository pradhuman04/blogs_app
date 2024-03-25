# Create users
user1 = User.create!(
  email: 'user1@example.com',
  password: 'password123',
  username: 'user1'
)

user2 = User.create!(
  email: 'user2@example.com',
  password: 'password456',
  username: 'user2'
)

# Create blogs for user1
Blog.create!(
  title: 'First Blog Post',
  content: 'This is the content of the first blog post.',
  user: user1
)

Blog.create!(
  title: 'Second Blog Post',
  content: 'This is the content of the second blog post.',
  user: user1
)

# Create blogs for user2
Blog.create!(
  title: 'User2 Blog Post',
  content: 'This is the content of the blog post by user2.',
  user: user2
)

puts 'Seed data created successfully.'
