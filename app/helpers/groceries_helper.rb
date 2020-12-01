module GroceriesHelper
  def groceries_counter
    if current_user.nil?
      return 0
    end
    Grocery.where(user: current_user).size
  end
end