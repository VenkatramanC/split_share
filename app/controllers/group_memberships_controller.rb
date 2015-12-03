class GroupMembershipsController < ApplicationController
  def create
    @group = Group.find(params[:group_membership][:group_id])
     email = params[:group_membership][:email]
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
      if email.match(Devise.email_regexp)
        invited_user = User.invite!(:email => email)
        invited_user.invited_group = @group
        invited_user.save!
        flash[:alert] = "Invitation Sent Successfully"
      else
        flash[:alert] = "Invalid E-Mail"
      end
    end
    
    redirect_to @group
  end
end
