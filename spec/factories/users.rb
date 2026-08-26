FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              { 'abc123' }
    password_confirmation { password }
    first_name            { '太郎' }
    last_name             { '山田' }
    first_name_kana       { 'タロウ' }
    last_name_kana        { 'ヤマダ' }
    birth_date            { Date.new(2000, 1, 1) }
  end
end
