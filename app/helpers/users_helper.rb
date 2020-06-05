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
end
