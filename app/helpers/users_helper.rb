module UsersHelper
  include Pagy::Frontend
  def gravatar_for(user, size: 80, cl: "gravatar")
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=robohash&?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: cl)
  end
end
