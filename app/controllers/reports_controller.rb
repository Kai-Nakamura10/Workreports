class ReportsController < ApplicationController
  before_action :require_login
  before_action :set_report, only: %i[edit update show destroy]

  def index
    @reports = current_user.reports.order(created_at: :desc)
  end

  def new
    @report = current_user.reports.new
  end

  def edit
  end

  def show
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to reports_path, notice: '日報を登録しました'
    else
      flash.now[:alert] = '登録に失敗しました'
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to reports_path, notice: '日報を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_path, notice: '日報を削除しました'
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :body)
  end
end
