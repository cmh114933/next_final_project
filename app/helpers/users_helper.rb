module UsersHelper

	def avatar_for(user, options = {size: 50})
		size = options[:size]
		if user.avatars?
			image_tag user.avatars[0].url(:thumb), width: size, class: 'avatar-image'
		else
			image_tag 'default_avatar.png', width: size, class: 'avatar-image'
		end
	end

end
