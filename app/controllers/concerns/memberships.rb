module Memberships
  def update_memberships(user = nil)
    set_membership_user(user)
    destroy_demo_membership unless @membership_user.memberships.empty?
    create_demo_membership if @membership_user.memberships.empty?
    set_current_membership
  end

  def clear_current_membership(user = nil)
    set_membership_user(user)
    current = @membership_user.memberships.detect(&:current)
    current.update_attributes(current: false) if current
  end

  private

  def set_membership_user(user)
    @membership_user = user || current_user
  end

  def destroy_demo_membership
    demo_membership = Membership.find_by(
      community: Community.demo,
      user: @membership_user
    )

    demo_membership.destroy if demo_membership.present?
  end

  def create_demo_membership
    Membership.create(
      community: Community.demo,
      user: @membership_user,
      role: Membership::ROLES.first
    )
  end

  def set_current_membership
    unless @membership_user.memberships.detect(&:current)
      @membership_user
        .memberships
        .order(:created_at)
        .last
        .update_attributes(current: true)
    end
  end
end
