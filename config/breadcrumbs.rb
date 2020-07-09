crumb :root do
  link "HOME", root_path
end

crumb :about do
  link "ABOUT", about_path
end

crumb :notifications do
  link "通知", notifications_path
  parent :root
end

crumb :favorites do
  link "お気に入り", favorites_path
  parent :root
end


crumb :shops do
  link "SHOPS", shops_path
end

crumb :users do
  link "MEMBERS", users_path
  parent :root
end
