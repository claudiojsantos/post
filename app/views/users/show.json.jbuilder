json.user do
  json.array! @user do |user|
    json.id user.id.to_s
    json.nome user.name
    json.email user.email
  end
end

json.current_page @user.current_page
json.total_pages @user.total_pages
