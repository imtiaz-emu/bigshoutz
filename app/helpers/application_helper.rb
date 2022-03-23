module ApplicationHelper
  Role.all.each do |role|
    define_method :"is_#{role.name.downcase}?" do
      current_user&.roles&.include?(role)
    end
  end

  def current_profile?(profile)
    current_profile == profile
  end

  def current_profile
    current_user&.profile
  end

  def active_sidebar(nav)
    params[:action] == nav ? 'active' : ''
  end

  def services
    Service.active
  end

  def owner_of?(object)
    current_user == object.user
  end
end
