FactoryGirl.define do
  factory :wiki do
    title "MyString"
    body "MyText"
    private false
    user
  end
end