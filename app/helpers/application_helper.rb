module ApplicationHelper

  def active_class?(test_path)
    return "active" if current_page?(test_path)
  end
end
