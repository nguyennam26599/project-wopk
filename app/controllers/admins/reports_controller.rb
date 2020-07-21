# frozen_string_literal: true

module Admins
  class ReportsController < BaseController
    before_action :set_posts, only: %i[index]

    def index; end

    def show_post
      @post = Post.find_by(id: params[:id])
      @reports = Report.where(reportable: @post)
    end

    def create
      @report = Report.new report_params
      if @report.save
        respond_to do |format|
          format.html
          format.js
        end
        flash[:noice] = 'Ban da report thanh cong'
      else
        flash[:danger] = ' Co loi xay ra, vui long thu lai'
      end
    end

    def report_post
      @report = Report.find_by(id: params[:report])
      @post = @report.reportable
      Report.all.where(reportable: @post).destroy_all
      @post.update status: params[:post_status]
      redirect_to admins_reports_path
    end

    def noreport_post
      @report = Report.find_by(id: params[:report])
      return redirect_to admins_reports_path if @report.destroy
    end

    private

    def report_params
      params.require(:report).permit(:reportable_id, :reportable_type, :user_id, :content, :status)
    end

    def set_posts
      @reports = Report.all
      @posts = []
      @reports.each do |report|
        @posts.push(report.reportable)
      end
      @posts.uniq!
    end
  end
end
