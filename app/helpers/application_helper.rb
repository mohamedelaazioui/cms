module ApplicationHelper
  def language_switcher
    content_tag(:div, class: "btn-group", role: "group") do
      I18n.available_locales.map do |locale|
        link_to(
          locale.to_s.upcase,
          url_for(locale: locale),
          class: "btn btn-sm #{locale == I18n.locale ? 'btn-primary' : 'btn-outline-primary'}",
          title: locale_name(locale)
        )
      end.join.html_safe
    end
  end

  def locale_name(locale)
    case locale.to_sym
    when :en
      "English"
    when :ja
      "日本語"
    else
      locale.to_s
    end
  end

  def meta_title
    content_for?(:meta_title) ? content_for(:meta_title) : "CMS - Content Management System"
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) :
      "Professional CMS platform built with Ruby on Rails. Manage your content efficiently with our modern content management system."
  end

  def meta_keywords
    content_for?(:meta_keywords) ? content_for(:meta_keywords) :
      "CMS, content management, Ruby on Rails, web development, services, EIKEN, grammar, junior high school exam, French, English, extra activities, programming, education, language learning"
  end

  def meta_image
    content_for?(:meta_image) ? content_for(:meta_image) :
      "#{request.base_url}/icon.png"
  end

  def canonical_url
    content_for?(:canonical_url) ? content_for(:canonical_url) : request.original_url
  end

  def get_service_icon_class(title)
    case title.downcase
    when /eiken|英検/
      "fas fa-award"
    when /grammar|英文法|文法/
      "fas fa-book"
    when /french|フランス語/
      "fas fa-language"
    when /exam|受験/
      "fas fa-graduation-cap"
    when /scratch|programming|プログラミング/
      "fas fa-code"
    when /japanese|日本語/
      "fas fa-globe"
    else
      "fas fa-star"
    end
  end

  def safe_external_link(url, text = nil, html_options = {})
    return "" if url.blank?

    # Sanitize URL to prevent XSS
    begin
      uri = URI.parse(url)
      # Only allow http and https schemes
      return "" unless %w[http https].include?(uri.scheme)

      sanitized_url = uri.to_s
    rescue URI::InvalidURIError
      return ""
    end

    text ||= sanitized_url
    default_options = { target: "_blank", rel: "noopener noreferrer" }
    link_to text, sanitized_url, default_options.merge(html_options)
  end
end
