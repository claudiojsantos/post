json.users do
  json.array! @users do |user|
    json.id user.id.to_s
    json.nome user.name
    json.email user.email
  end
end

json.current_page @users.current_page
json.total_pages @users.total_pages
