crumb :root do
  link "HOME", root_path
end

crumb :about do
  link "ABOUT", about_path
end

crumb :notifications do
  link "お知らせ", notifications_path
  parent :root
end

crumb :shops do
  link "SHOPS", shops_path
end

crumb :users do
  link "MEMBERS", users_path
  parent :root
end
