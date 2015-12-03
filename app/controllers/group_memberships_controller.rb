class GroupMembershipsController < ApplicationController
  def create
    @group = Group.find(params[:group_membership][:group_id])
    usr = User.find_by(email: params[:group_membership][:email])
    if usr
      @group.add(usr)
     flash[:notice] = "Member Added"
    else
      flash[:alert] = "No Such user"
    end
    redirect_to @group
  end
end
