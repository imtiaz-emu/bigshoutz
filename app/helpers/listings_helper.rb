module ListingsHelper
  def list_of_celebrities
    User.celebrities_with_complete_profile.map { |celebrity| [celebrity.profile.full_name, celebrity.id] }
  end
end
