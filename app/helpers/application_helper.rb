module ApplicationHelper
  ALERT_TYPES = [:success, :info, :warning, :danger] unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash(options = {})
    flash_messages = []

    flash.each do |type, message|
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger  if type == :alert
      type = :danger  if type == :error
      next unless ALERT_TYPES.include?(type)

      tag_options = {
        class: "alert alert-#{type} alert-dismissible fade show col-md-6 my-3"
      }.merge(options)

      close_button = content_tag(:button, '', type: "button", class: "btn-close", "data-dismiss" => "alert", 'area-label' => 'Close')

      Array(message).each do |msg|
        text = content_tag(:div, raw(msg + close_button), tag_options)
        flash_messages << text if msg
      end
    end

    flash_messages.join("\n").html_safe
  end

  def user_avatar(user)
    user.avatar? ? user.avatar.url : asset_pack_path('media/images/user.png')
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_pack_path('media/images/event.jpg')
    end
  end

  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_pack_path('media/images/event_thumb.jpg')
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      asset_pack_path('media/images/user.png')
    end
  end
end
