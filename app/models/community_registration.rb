class CommunityRegistration
  include ActiveModel::Model
  
  attr_accessor :community_name, :community_level, :errors, :terms_agreement

  def errors
    @errors ||= []
  end

  def valid?
    errors << "Terms and Conditions agreement required" unless terms_agreement.present?
    errors << "Community level required" unless community_level.present?
    errors << "Community name required" unless community_name.present?
    errors << "Community name taken" unless community.valid?
    errors.empty?
  end

  private

  def community
    @community ||= Community.new(name: community_name)
  end

end
