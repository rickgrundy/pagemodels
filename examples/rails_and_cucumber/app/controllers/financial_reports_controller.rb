class FinancialReportsController < ApplicationController
  def show
    @year = params[:year]
    @txn_type = params[:txn_type]
    @txns = Transaction.find_all(:year => @year, :type => @txn_type)
  end
end