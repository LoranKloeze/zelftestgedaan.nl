class SelfTestsController < ApplicationController
  before_action :set_self_test, only: %i[show edit update destroy]

  # GET /self_tests or /self_tests.json
  def index
    @self_test_groups =
      SelfTest
      .select('done_at, COUNT(*) as total, COUNT(*) FILTER(WHERE is_positive = true) as total_positive')
      .group(:done_at)
      .order(done_at: :desc)
  end

  # GET /self_tests/new
  def new
    redirect_to :too_soon and return if is_too_soon
    @self_test = SelfTest.new(done_at: Date.today)
  end

  # POST /self_tests or /self_tests.json
  def create
    redirect_to :too_soon and return if is_too_soon

    @self_test = SelfTest.new(self_test_params)
    @self_test.reference = create_reference

    respond_to do |format|
      if @self_test.save
        session[:last_test_inserted_at] = DateTime.now
        format.html { redirect_to thanks_path, notice: 'Self test was successfully created.' }
        format.json { render :show, status: :created, location: @self_test }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @self_test.errors, status: :unprocessable_entity }
      end
    end
  end

  def already_done; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_self_test
    @self_test = SelfTest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def self_test_params
    params.require(:self_test).permit(:done_at, :is_positive)
  end

  def create_reference
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), Rails.application.credentials.key, request.remote_ip)
  end

  def is_too_soon
    session[:last_test_inserted_at].present? && (DateTime.now.to_i - DateTime.parse(session[:last_test_inserted_at]).to_i) < 1800
  end
end
