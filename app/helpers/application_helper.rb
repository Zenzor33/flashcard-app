module ApplicationHelper
  def current_or_default(path)
    current = 'bg-gray-900 text-white'
    default = "text-gray-300 hover:bg-gray-700 hover:text-white" 
    current_page?(path) ? current : default
  end 

  def navbar_link_class(path)
    "#{current_or_default(path)} rounded-md px-3 py-2 text-sm font-medium"
  end 
end
