Raygun.setup do |config|
  config.api_key = "WptPgsydLBe0DwSt1o7N2A=="
  config.filter_parameters = Rails.application.config.filter_parameters

  # The default is Rails.env.production?
  # config.enable_reporting = !Rails.env.development? && !Rails.env.test?
end
