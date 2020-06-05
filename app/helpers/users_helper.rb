# frozen_string_literal: true

module UsersHelper
  def default_avatar_user(user)
    if user.avatar.blank?
      '/default-user-avatar.png'
    else
      url_for(user.avatar)
    end
  end

  def regex_name_validate
    '^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ' \
    'ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ' \
    'ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$'
  end

  def avatar_for(user, avt_class)
    @avatar = user.avatar
    @avatar_user = if @avatar.blank?
                     image_tag('/default-user-avatar.png', class: avt_class.to_s, alt: user.name)
                   else
                     image_tag(user.avatar, class: avt_class.to_s, alt: user.name)
                   end
  end

  def btn_edit
    if current_user == @user
      link_to 'Edit Users', '#', class: 'text-dark'
    else
      'Follow'
    end
  end
end
