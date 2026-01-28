# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create an admin user
unless Admin.exists?(email: 'admin@example.com')
  Admin.create!(
    email: 'admin@example.com',
    password: 'password123',
    password_confirmation: 'password123'
  )
  puts "Created admin user: admin@example.com / password123"
end

# Create sample pages
unless Page.exists?
  Page.create!([
    {
      title: 'Welcome to Our Site',
      slug: 'welcome',
      published: true,
      locale: 'en',
      content: '<p>Welcome to our CMS-powered website!</p>'
    },
    {
      title: 'Privacy Policy',
      slug: 'privacy-policy',
      published: true,
      locale: 'en',
      content: '<p>Our privacy policy content goes here.</p>'
    }
  ])
  puts "Created sample pages"
end

# Create sample services
unless Service.exists?
  Service.create!([
    {
      title: 'Web Development',
      description: 'We build modern, responsive websites using the latest technologies.',
      position: 1
    },
    {
      title: 'Mobile Apps',
      description: 'Native and cross-platform mobile applications for iOS and Android.',
      position: 2
    },
    {
      title: 'Consulting',
      description: 'Expert advice on technology strategy and digital transformation.',
      position: 3
    }
  ])
  puts "Created sample services"
end

# Create sample testimonials
unless Testimonial.exists?
  Testimonial.create!([
    {
      name: 'John Doe',
      quote: 'Excellent service! The team delivered our project on time and exceeded our expectations.'
    },
    {
      name: 'Jane Smith',
      quote: 'Professional, responsive, and talented. Highly recommend their services!'
    },
    {
      name: 'Bob Johnson',
      quote: 'Great experience working with this team. Will definitely work with them again.'
    }
  ])
  puts "Created sample testimonials"
end

# Create sample social links
unless SocialLink.exists?
  SocialLink.create!([
    {
      name: 'Twitter',
      url: 'https://twitter.com/example'
    },
    {
      name: 'Facebook',
      url: 'https://facebook.com/example'
    },
    {
      name: 'LinkedIn',
      url: 'https://linkedin.com/company/example'
    }
  ])
  puts "Created sample social links"
end

puts "\n✅ Database seeded successfully!"
puts "Admin login: admin@example.com / password123"
