module ApplicationHelper

  def flash_class(level)
    bootstrap_alert_class = {
      "success" => "alert-success",
      "error" => "alert-danger",
      "notice" => "alert-info",
      "alert" => "alert-danger",
      "warn" => "alert-warning"
    }
    
    bootstrap_alert_class[level]
  end


  def active_class(path)
    if request.path == path
      return 'active'
    else
      return ''
    end
  end

  def active_menu(path)
    if request.path == path
      return 'btn-active'
    else
      return ''
    end
  end

  def active_sidemenu(path)
    if request.path == path
      return 'sidemenu-active'
    else
      return ''
    end
  end

  def hide_class(path)
    if request.path == path
      return 'd-none'
    else
      return ''
    end
  end

  def has_upvoted?(post_id, user_id)
    return !Vote.where(post_id: post_id, user_id: user_id, upvote: 1).empty?
  end

  def has_downvoted?(post_id, user_id)
      return !Vote.where(post_id: post_id, user_id: user_id, downvote: 1).empty?
  end

end
