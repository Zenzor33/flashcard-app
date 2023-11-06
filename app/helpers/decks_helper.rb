module DecksHelper
  def user_deck_classes(category)
    "rounded-full bg-white px-4 py-2.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 #{'bg-green-500 text-white hover:text-black hover:bg-green-500' if params[:category] == category}" 
  end
end
