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

  def btn_edit
    if current_user == @user
      link_to 'Edit Users', '#', class: 'text-dark'
    else
      'Follow'
    end
  end

  def unfollow_user(user)
    current_user.followings.find_by(following_id: user.id)
  end

  def user_status(user)
    case user.status
    when User::ACTIVED_STATUS
      'text-success'
    when User::DEACTIVED_STATUS
      'text-warning'
    else
      'text-danger'
    end
  end
end
