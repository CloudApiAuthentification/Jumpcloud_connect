require "orchestrator"

class AuthPipeline < Orchestrator::Composer
  compose :local, klass: VerifyEmailLocal
  compose :jumpcloud, klass: VerifyEmailJumpCloud
end

class VerifyEmailLocal < Orchestrator::Layer
  required email, String

  def call(input : Hash)
    exist = User.where(email: email)

    Monads::Success.new({ :email => email, :fetch_jump_cloud => !exist })
    # Monads::Success.new(input.merge({ fetch_jump_cloud: !exist }))
  end
end

class VerifyEmailJumpCloud < Orchestrator::Layer
  required email, String
  required fetch_jump_cloud, Bool

  def call(input : Hash)
    return Monads::Success.new(input) if fetch_jump_cloud == false

    # Call Jumpcloud
    found = false

    if found
      Monads::Success.new(input)
    else
      Monads::Failure.new({ :error => :invalid_user })
    end
  end
end
