module ListingsHelper
  def list_of_celebrities
    User.celebrities.map { |celebrity| [celebrity.profile.full_name, celebrity.id] }
  end
end
