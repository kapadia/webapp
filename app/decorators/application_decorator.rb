class ApplicationDecorator < Draper::Decorator 
  delegate_all

  def ass_name(association)
    ass = object.send(association, name)
    ass.name if ass.present?
  end

  def mnfg_name
    if object.manufacturer.name == "Other" and object.manufacturer_other.present?
      object.manufacturer_other
    else
      object.manufacturer.name
    end
  end

  def dl_list_item(dd = nil, dt)
    return nil unless dd.present?
    html = h.content_tag(:dt, dt)
    html << h.content_tag(:dd, dd)
    html.html_safe
  end

  def dl_from_attribute(attribute, title = nil)
    description = if_present(attribute)
    return nil unless description
    title = attribute.titleize unless title.present?
    self.dl_list_item(description, title)
  end

  def dl_from_attribute_othered(attribute, title = nil)
    description = ass_name(attribute)
    return nil unless description
    if description == "Other style"
      other = if_present("#{attribute}_other")
      description = other if other.present?
    end
    title = attribute.titleize unless title.present?
    self.dl_list_item(description, title)
  end

  def if_present(attribute, action = nil)
    if object.send(attribute).present?
      return action if action.present?
      object.send(attribute)
    end
  end

  def twitterable(user)
    if user.show_twitter and user.twitter
     h.link_to 'Twitter', user.twitter
    end
  end

  def websiteable(user)
    if user.show_website and user.website
      h.link_to 'Website', user.website
    end
  end

  def show_twitter_and_website(user)
    if twitterable(user) or websiteable(user)
      html = ""
      if twitterable(user)
        html << twitterable(user)
        html << " and #{websiteable(user)}" if websiteable(user)
      else
        html << websiteable(user)
      end
      html.html_safe
    end
  end

end