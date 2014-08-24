module ApplicationHelper
  def translate_flash_class klass
    case klass.to_sym
    when :error
      :danger
    when :notice
      :success
    when :alert
      :info
    else
      klass.to_sym
    end
  end

  def markdown text
    Markdown.render(text).html_safe
  end
end
