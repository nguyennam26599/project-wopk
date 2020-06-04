# frozen_string_literal: true

module UsersHelper
  include Pagy::Frontend
  def avatar_for(user, avt_class, id_avatar)
    if user.avatar.blank?
      image_tag('/default-user-avatar.png', class: avt_class.to_s, alt: user.name, id: id_avatar.to_s)
    else
      image_tag(user.avatar, class: avt_class.to_s, alt: user.name, id: id_avatar.to_s)
    end
  end

  def regex_name_validate
    "^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
    "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
    "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$"
  end
end
