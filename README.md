### Rails Project README

This README provides an overview of the Rails project and its functionalities.

#### Project Overview:

The project aims to create a basic Rails application allowing users to perform login and registration without relying on any gems. Additionally, it provides APIs for login, registration, and fetching a list of posts/blogs. The project is structured to accommodate both API-only and view-based controllers. RSpec tests have been implemented to ensure the functionality of actions.

#### Requirements:

- Ruby 2.7.5
- Rails 6.1.4
- PostgreSQL as the database
- Puma as the app server

#### Gems Used:

- **Kaminari**: For pagination.
- **Bootstrap 4.6.0**: For UI styling.
- **RSpec-Rails**: For testing.
- **Faker**: For generating fake data.
- **Factory Bot Rails**: For creating test data.
- **Rails Controller Testing**: Provides tools to test Rails controllers.
- **Shoulda Matchers**: Simplifies testing by providing RSpec matchers.

#### Installation:

1. Clone the repository.
2. Make sure you have Ruby 2.7.5 installed.
3. Install required gems using Bundler: `bundle install`
4. Set up the database: `rails db:create && rails db:migrate`
5. Seed the database: `rails db:seed`

#### Running Tests:

RSpec tests have been provided to ensure the functionality of actions. Run the tests using:

```bash
rspec
