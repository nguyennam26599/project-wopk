# frozen_string_literal: true

module ReportsHelper
  def post_count_reports(post)
    Report.all.where(reportable: post).size
  end

  def user_report(report)
    User.find_by(id: report.user_id)
  end
end
