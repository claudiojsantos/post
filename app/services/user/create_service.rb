class User::CreateService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    @user.save
  end
end
