module ServicesHelper
  def service_statuses
    { 'true': 'success', 'false': 'danger' }.with_indifferent_access.freeze
  end
end
