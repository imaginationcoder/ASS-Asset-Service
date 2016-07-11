module ApplicationHelper

  #the form calls helpers which are specified by Devise and so aren't present when you access a Devise form from a non-Devise controller.
  #To get around this, need to add the following methods to the helper class of the controller you wish to display the form under.
  # Alternatively, we can just add them to application helper to make them available anywhere.
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # elegant page title
  def page_title(title = nil)
    if title.present?
      content_for :title, title
    else
      content_for?(:title) ? t('app.title') + ' | ' + content_for(:title) : t('app.title')
    end
  end

  # SEO meta tags based on page
  # in view <%= meta_keywords('hello', 'world') %>
  def meta_keywords(tags = nil)
    if tags.present?
      content_for :meta_keywords, tags
    else
      kws = t('app.meta.keywords')
      content_for?(:meta_keywords) ? [content_for(:meta_keywords), kws].join(', ') : kws
    end
  end
  # SEO meta description based on page
  # in view <%= meta_description('Hello page based meta description goes here') %>
  def meta_description(desc = nil)
    if desc.present?
      content_for :meta_description, desc
    else
      content_for?(:meta_description) ? content_for(:meta_description) : t('app.meta.description')
    end
  end

  def bootstrap_class_for flash_type
    { success: 'alert-success', error: 'alert-danger',
      alert: 'alert-warning', notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def space
    '&nbsp;'.html_safe
  end

  # helper for a button disabled with progressing text on sumbit
  def btn_prog_text(text)
    "<i class='fa fa-circle-o-notch fa-spin'></i> #{text}".html_safe
  end

end
