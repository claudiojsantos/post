class User::UpdateService
  attr_reader :errors

  def initialize(user, params)
    @user = user
    @params = params
    @errors = []
  end

  def call
    return false unless @user

    if @user.update(@params) && @user.valid?
      true
    else
      @errors = @user.errors.full_messages
      false
    end
  end
end
