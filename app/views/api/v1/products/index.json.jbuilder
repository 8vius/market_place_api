json.products @products do |product|
  json.extract!(
    product,
    :id,
    :title,
    :price,
    :published,
    :user_id,
    :created_at,
    :updated_at,
  )

  json.user product.user, :id, :email, :created_at, :updated_at
end
