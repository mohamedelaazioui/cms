class HealthController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    # Check database connectivity
    database_status = check_database
    
    # Check Redis connectivity
    redis_status = check_redis
    
    # Overall health
    healthy = database_status && redis_status
    
    status_code = healthy ? :ok : :service_unavailable
    
    render json: {
      status: healthy ? "healthy" : "unhealthy",
      timestamp: Time.current.iso8601,
      services: {
        database: database_status ? "up" : "down",
        redis: redis_status ? "up" : "down"
      },
      version: Rails.application.config.version || "unknown"
    }, status: status_code
  end

  def ready
    # Readiness check - can the app serve requests?
    database_ready = check_database
    
    render json: {
      ready: database_ready,
      timestamp: Time.current.iso8601
    }, status: database_ready ? :ok : :service_unavailable
  end

  def live
    # Liveness check - is the app running?
    render json: {
      alive: true,
      timestamp: Time.current.iso8601
    }, status: :ok
  end

  private

  def check_database
    ActiveRecord::Base.connection.active?
  rescue StandardError
    false
  end

  def check_redis
    Redis.new(url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0")).ping == "PONG"
  rescue StandardError
    false
  end
end
