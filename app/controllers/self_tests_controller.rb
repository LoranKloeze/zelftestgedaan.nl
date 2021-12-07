class SelfTestsController < ApplicationController
  before_action :guard_too_soon, only: %i[new create]

  def index
    @self_test_groups = SelfTest.grouped_by_done
  end

  def new
    @self_test = SelfTest.new(done_at: Date.today)
  end

  def create
    @self_test = SelfTest.new(self_test_params)
    @self_test.reference = fetch_reference

    if @self_test.save
      session[:last_test_inserted_at] = DateTime.now
      redirect_to thanks_path
    else
      raise 'We got very weird self test params, fail hard and let the 1337 skid figure it out'
    end
  end

  private

  def self_test_params
    params.require(:self_test).permit(:done_at, :is_positive)
  end

  def fetch_reference
    keep_ip_in_cache_for = 30.minutes
    Rails.cache.fetch("#{request.remote_ip}/test_done", expires_in: keep_ip_in_cache_for) { SecureRandom.hex }
  end

  def guard_too_soon
    redirect_to :too_soon if too_soon?
  end

  def too_soon?
    wait_for = 15.minutes
    session[:last_test_inserted_at].present? &&
      (DateTime.now.to_i - DateTime.parse(session[:last_test_inserted_at]).to_i) < wait_for.to_i
  end
end
