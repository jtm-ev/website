
class GroupMembershipsController < ApplicationController
  respond_to :html, :js
  
  def create
    Rails.logger.info "CREATE: #{params.inspect}"
    @group_membership = GroupMembership.create(params[:group_membership])
    respond_with()
  end
end