# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create an admin user
unless Admin.exists?(email: 'mohamed.elaazioui@gibugumi.com')
  Admin.create!(
    email: 'mohamed.elaazioui@gibugumi.com',
    password: 'CHOCOpeche-123',
    password_confirmation: 'CHOCOpeche-123'
  )
  puts "Created admin user: mohamed.elaazioui@gibugumi.com / CHOCOpeche-123"
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
# Clear existing services and recreate with educational content
Service.destroy_all

# English Services
Service.create!([
  {
    title: 'EIKEN Test Preparation',
    description: 'Comprehensive EIKEN test preparation for all levels (5 to 1). Expert guidance to help students pass their exams with confidence.',
    position: 1,
    locale: 'en'
  },
  {
    title: 'English Grammar',
    description: 'Master English grammar fundamentals through interactive lessons and practical exercises. Perfect for students of all levels.',
    position: 2,
    locale: 'en'
  },
  {
    title: 'French Language Classes',
    description: 'Learn French from beginner to advanced levels. Native speaker instruction with focus on conversation and cultural understanding.',
    position: 3,
    locale: 'en'
  },
  {
    title: 'Junior High School Exam Prep',
    description: 'Complete preparation for junior high school entrance exams. Covering all subjects with proven study methods and practice tests.',
    position: 4,
    locale: 'en'
  },
  {
    title: 'Programming with Scratch',
    description: 'Introduction to programming for kids using Scratch. Learn coding fundamentals through fun, interactive projects and games.',
    position: 5,
    locale: 'en'
  },
  {
    title: 'Japanese Language Support',
    description: 'Japanese language assistance for international students and professionals. Reading, writing, speaking, and cultural adaptation support.',
    position: 6,
    locale: 'en'
  }
])

# Japanese Services
Service.create!([
  {
    title: '英検対策',
    description: '英検5級から1級まで全レベルの試験対策。自信を持って合格できるよう専門的な指導を提供します。',
    position: 1,
    locale: 'ja'
  },
  {
    title: '英文法',
    description: 'インタラクティブなレッスンと実践的な演習を通じて英文法の基礎を習得。全レベルの生徒に最適です。',
    position: 2,
    locale: 'ja'
  },
  {
    title: 'フランス語クラス',
    description: '初級から上級までフランス語を学習。会話と文化理解に焦点を当てたネイティブスピーカーによる指導。',
    position: 3,
    locale: 'ja'
  },
  {
    title: '中学受験対策',
    description: '中学受験の完全対策。実績のある学習方法と模擬試験で全科目をカバー。',
    position: 4,
    locale: 'ja'
  },
  {
    title: 'Scratchプログラミング',
    description: 'Scratchを使用した子供向けプログラミング入門。楽しいインタラクティブなプロジェクトとゲームを通じてコーディングの基礎を学習。',
    position: 5,
    locale: 'ja'
  },
  {
    title: '日本語サポート',
    description: '留学生や外国人専門家向けの日本語支援。読み書き、会話、文化適応のサポート。',
    position: 6,
    locale: 'ja'
  }
])
puts "Created educational services (EN & JA)"

# Create sample testimonials
Testimonial.destroy_all

# English Testimonials
Testimonial.create!([
  {
    name: 'Sarah Johnson',
    quote: 'Excellent EIKEN preparation! My daughter passed Grade 2 on her first try thanks to the comprehensive lessons and practice materials.',
    locale: 'en'
  },
  {
    name: 'Michael Chen',
    quote: 'The French classes are outstanding. Native speaker instruction really helped improve my pronunciation and conversational skills.',
    locale: 'en'
  },
  {
    name: 'Emily Williams',
    quote: 'My son loves the Scratch programming course! He created his first game and is so excited about coding now.',
    locale: 'en'
  }
])

# Japanese Testimonials
Testimonial.create!([
  {
    name: '田中 花子',
    quote: '英検対策が素晴らしかったです！娘は初回で2級に合格しました。包括的なレッスンと練習教材のおかげです。',
    locale: 'ja'
  },
  {
    name: '佐藤 太郎',
    quote: 'フランス語のクラスが最高です。ネイティブスピーカーの指導で発音と会話力が本当に向上しました。',
    locale: 'ja'
  },
  {
    name: '山田 美咲',
    quote: '息子はScratchプログラミングコースが大好きです！初めてゲームを作って、今はコーディングにとても興奮しています。',
    locale: 'ja'
  }
])
puts "Created sample testimonials (EN & JA)"

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
puts "Admin login: mohamed.elaazioui@gibugumi.com / CHOCOpeche-123"
