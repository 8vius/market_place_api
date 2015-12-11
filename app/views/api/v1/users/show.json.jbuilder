json.user do |json|
  json.extract! @user, :id, :email, :created_at, :updated_at, :auth_token

  json.product_ids @user.products, :id
end
