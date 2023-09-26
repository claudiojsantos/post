RSpec::Matchers.define :custom_have_http_status do |expected|
  match do |actual|
    actual.status == expected
  end

  failure_message do |actual|
    "expected that response to have status #{expected}, but it was #{actual.status}, with body #{actual.body}"
  end
end
