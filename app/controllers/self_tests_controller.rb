class SelfTestsController < ApplicationController
  before_action :guard_wait, only: %i[new create]

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
      increment_tests_submitted
      redirect_to thanks_path(is_positive: @self_test.is_positive)
    else
      raise 'We got very weird self test params, fail hard and let the 1337 skid figure it out'
    end
  end

  def wait
    @tests_interval = Setting.new_tests_interval / 1.minutes
    @tests_limit = Setting.tests_limit_per_request
  end

  private

  def self_test_params
    params.require(:self_test).permit(:done_at, :is_positive)
  end

  def fetch_reference
    keep_ip_in_cache_for = 30.minutes
    Rails.cache.fetch("#{request.remote_ip}/test_done", expires_in: keep_ip_in_cache_for) { SecureRandom.hex }
  end

  def guard_wait
    redirect_to :wait_self_tests if limit_reached?
  end

  def limit_reached?
    session[:tests_submitted] = 0 and return false if may_clear_limit? || session[:tests_submitted].blank?

    session[:tests_submitted] >= Setting.tests_limit_per_request
  end

  def increment_tests_submitted
    session[:tests_submitted] ||= 0
    session[:tests_submitted] += 1
  end

  def may_clear_limit?
    return true if session[:last_test_inserted_at].blank?

    passed_since_last_test = (DateTime.now.to_i - DateTime.parse(session[:last_test_inserted_at]).to_i)

    passed_since_last_test > Setting.new_tests_interval.to_i
  end
end
