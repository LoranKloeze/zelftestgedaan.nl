class SelfTestsController < ApplicationController
  before_action :set_self_test, only: %i[show edit update destroy]

  # GET /self_tests or /self_tests.json
  def index
    @self_test_groups =
      SelfTest
      .select('done_at, COUNT(*) as total, COUNT(*) FILTER(WHERE is_positive = true) as total_positive')
      .group(:done_at)
  end

  # GET /self_tests/new
  def new
    @self_test = SelfTest.new(done_at: Date.today)
  end

  # POST /self_tests or /self_tests.json
  def create
    @self_test = SelfTest.new(self_test_params)

    respond_to do |format|
      if @self_test.save
        format.html { redirect_to thanks_path, notice: 'Self test was successfully created.' }
        format.json { render :show, status: :created, location: @self_test }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @self_test.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_self_test
    @self_test = SelfTest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def self_test_params
    params.require(:self_test).permit(:done_at, :is_positive, :ip_reference)
  end
end
