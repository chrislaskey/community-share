class BulkMembership

  include ActiveModel::Model

  attr_accessor :role, :data, :community, :rows

  validates :role, presence: true
  validates :data, presence: true
  validates :community, presence: true
  validates :rows, presence: true
  validates :count, numericality: { greater_than: 0 }

  def create
    if valid?
      ActiveRecord::Base.transaction do
        create_memberships!
      end
    end
  rescue StandardError => e
    errors.add(:base, e)
    false
  end

  def rows
    return [] unless data.present?

    @rows ||= data
      .tr(",", "\n")
      .gsub("\r\n", "\n")
      .split("\n")
      .map(&:strip)
      .select { |row| row.include? "@" }
      .compact
  end

  def count
    rows.length
  end

  private

  def create_memberships!
    rows.map do |row|
      create_membership! row
    end
  end

  def create_membership!(row)
    email, name = parse_email_and_name(row)
    user = User.find_or_create_by!(name: name, email: email)

    Membership.find_or_create_by!(community: community, role: role, user: user)
  end

  def parse_email_and_name(row)
    if row.include?("<") && row.include?(">")
      email_match = row.match(/<(.*)>/)
      email = email_match.captures[0]

      name_match = row.match(/^(.*)</)
      name = name_match.captures[0].strip
    else
      email = row
      name = nil
    end

    [email, name]
  end
end
