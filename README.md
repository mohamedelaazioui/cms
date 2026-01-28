# CMS - Content Management System

A fully functional Content Management System built with Ruby on Rails 8.

## Features

- **Admin Dashboard**: Comprehensive admin panel to manage all content
- **Pages Management**: Create and manage static pages with rich text editor
- **Services Management**: Showcase your services with descriptions and icons
- **Testimonials**: Display customer testimonials with ratings and avatars
- **Social Links**: Manage social media links
- **Contact Form**: Allow visitors to send messages
- **Responsive Design**: Built with Bootstrap 5 for mobile-friendly layouts
- **Authentication**: Secure admin authentication with Devise

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd cms
   ```

2. Install dependencies:
   ```bash
   bundle install
   yarn install
   ```

3. Set up the database:
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   bin/rails db:seed
   ```

4. Start the server:
   ```bash
   bin/rails server
   ```

5. Visit http://localhost:3000

## Admin Access

After running `db:seed`, you can log in to the admin panel:

- **URL**: http://localhost:3000/admins/sign_in
- **Email**: admin@example.com
- **Password**: password123

## Development

Run the development server:
```bash
bin/rails server
```

Run tests:
```bash
bin/rails test
```

## Tech Stack

- Ruby on Rails 8.0.4
- PostgreSQL
- Bootstrap 5.3
- Stimulus.js
- Turbo
- Action Text (Rich Text Editor)
- Active Storage (File Uploads)
- Devise (Authentication)
- FriendlyId (SEO-friendly URLs)

## Project Structure

```
app/
├── controllers/
│   ├── admin/          # Admin controllers
│   ├── public_controller.rb
│   └── contact_messages_controller.rb
├── models/
│   ├── admin.rb
│   ├── page.rb
│   ├── service.rb
│   ├── testimonial.rb
│   ├── social_link.rb
│   └── contact_message.rb
└── views/
    ├── admin/          # Admin views
    ├── public/         # Public-facing views
    └── layouts/
```

## Usage

### Managing Content

1. Log in to the admin panel
2. Navigate to the appropriate section (Pages, Services, Testimonials, Social Links)
3. Create, edit, or delete content as needed

### Viewing Public Site

- **Home**: `/`
- **About**: `/about`
- **Services**: `/services`
- **Testimonials**: `/testimonials`
- **Contact**: `/contact_messages/new`

## License

This project is available as open source.
