module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = decode_token(header)
    @current_user = User.find(decoded["user_id"]) if decoded
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')[0]
  end
end
