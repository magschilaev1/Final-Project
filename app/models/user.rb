# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  provider         :string(255)
#  uid              :string(255)
#  name             :string(255)
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  email            :string(255)
#  verified_maker   :boolean          default(FALSE)
#  github_username  :string(255)
#

class User < ActiveRecord::Base

  validates :github_username, presence: true
  validates :uid,             presence: true
  validates :provider,        presence: true

  def self.create_with_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.github_username = auth.info.login
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      # user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def confirm_maker
    self.verified_maker = true
    self.save
  end

  def self.verified_makers
    User.all.select{ |user| user.verified_maker? }
  end

  def github
    Github.new(github_username)
  end
end
