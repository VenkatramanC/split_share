class GroupMembershipsController < ApplicationController
  def create
    @group = Group.find(params[:group_membership][:group_id])
    usr = User.find_by(email: params[:group_membership][:email])
    if usr
      begin
        @group.add(usr)
      rescue
        flash[:notice] = "Already existed in group"
      
    else
      flash[:notice] = "Member Added"
      end
    else
      flash[:alert] = "No Such user"
    end
    redirect_to @group
  end
end
