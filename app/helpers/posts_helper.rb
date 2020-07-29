# frozen_string_literal: true

module PostsHelper
  def tagsinput_data(post)
    post.tags.pluck(:name).join(',')
  end

  def button_clip_post_check
    'bg-info text-white' if current_user.post_followings.exists?(id: @post.id)
  end

  def user_create_post?(post)
    current_user != post.user
  end

  def reading_time(post)
    (post.to_s.split.size / 265 + 1).to_s
  end

  def check_status_post(status)
    if status == 'public'
      'Published'
    else
      'Drafted'
    end
  end

  def date_create_post(val)
    if val > Date.today
      time_ago_in_words(val) + ' ago'
    elsif val > Time.now.beginning_of_week
      Time.parse(val.to_s).strftime('%A, %I:%M %p')
    else
      Time.parse(val.to_s).strftime('%B %d, %Y %I:%M %p')
    end
  end

  def my_date(val)
    Date.parse(val.to_s).strftime('%B %d, 20%y')
  end
end
