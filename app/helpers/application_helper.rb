module ApplicationHelper
  def flash_class(level)
    "flash alert alert-dismissable " +
    case level
      when :notice then "alert-info"
      when :success then "alert-success"
      else "alert-danger"
    end
  end

end
