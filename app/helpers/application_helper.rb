module ApplicationHelper
  def language_switcher
    content_tag(:div, class: 'btn-group', role: 'group') do
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
      'English'
    when :ja
      '日本語'
    else
      locale.to_s
    end
  end
end
