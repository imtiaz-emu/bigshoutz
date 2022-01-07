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
    current_user.profile
  end

  def can_destroy?
    self.class.reflect_on_all_associations.all? do |assoc|
      [
        %i[restrict_with_error restrict_with_exception].exclude?(assoc.options[:dependent]),
        (assoc.macro == :has_one && send(assoc.name).nil?),
        (assoc.macro == :has_many && send(assoc.name).empty?)
      ].any?
    end
  end

  def services
    Service.all
  end
end
