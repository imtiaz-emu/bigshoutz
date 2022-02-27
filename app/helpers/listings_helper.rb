module ListingsHelper
  def list_of_celebrities
    User.celebrities_with_complete_profile.map { |celebrity| [celebrity.profile.full_name, celebrity.id] }
  end

  def vote_numbers(listing)
    listing.vote_count < 0 ? "#{listing.vote_count * -1} Downvotes" : "#{listing.vote_count} Upvotes"
  end
end
