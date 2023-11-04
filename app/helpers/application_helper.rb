module ApplicationHelper
  def current_or_default(path)
    current = 'bg-gray-900 text-white'
    default = "text-gray-300 hover:bg-gray-700 hover:text-white" 
    current_page?(path) ? current : default
  end 
end
