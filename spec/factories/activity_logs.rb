FactoryBot.define do
  factory :activity_log do
    benutzer { nil }
    action { "MyString" }
    details { "MyText" }
  end
end
