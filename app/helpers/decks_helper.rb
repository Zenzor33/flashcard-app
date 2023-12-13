module DecksHelper
  def user_deck_classes(category=nil)
    default = "rounded-full px-4 py-2.5 text-sm font-semibold shadow-sm ring-1 ring-inset ring-gray-300"
    active = "bg-green-500 text-white hover:text-black hover:bg-green-500"
    inactive = "bg-white text-gray-900 hover:bg-gray-50"

    "rounded-full px-4 py-2.5 text-sm font-semibold shadow-sm ring-1 ring-inset ring-gray-300bg-green-500 text-white hover:text-black hover:bg-green-500"

    if params[:category] == category
      return default + " " + active 
    else  
      return default + " " + inactive
    end


    # "rounded-full px-4 py-2.5 text-sm font-semibold shadow-sm ring-1 ring-inset ring-gray-300 #{'bg-white text-gray-900 hover:bg-gray-50' if params[:category] != category} #{'bg-green-500 text-white hover:text-black hover:bg-green-500' if params[:category] == category}" 
  end
end
