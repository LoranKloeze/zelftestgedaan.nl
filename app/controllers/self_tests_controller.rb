class SelfTestsController < ApplicationController
  before_action :set_self_test, only: %i[ show edit update destroy ]

  # GET /self_tests or /self_tests.json
  def index
    @self_tests = SelfTest.all
  end

  # GET /self_tests/1 or /self_tests/1.json
  def show
  end

  # GET /self_tests/new
  def new
    @self_test = SelfTest.new
  end

  # GET /self_tests/1/edit
  def edit
  end

  # POST /self_tests or /self_tests.json
  def create
    @self_test = SelfTest.new(self_test_params)

    respond_to do |format|
      if @self_test.save
        format.html { redirect_to @self_test, notice: "Self test was successfully created." }
        format.json { render :show, status: :created, location: @self_test }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @self_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /self_tests/1 or /self_tests/1.json
  def update
    respond_to do |format|
      if @self_test.update(self_test_params)
        format.html { redirect_to @self_test, notice: "Self test was successfully updated." }
        format.json { render :show, status: :ok, location: @self_test }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @self_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /self_tests/1 or /self_tests/1.json
  def destroy
    @self_test.destroy
    respond_to do |format|
      format.html { redirect_to self_tests_url, notice: "Self test was successfully destroyed." }
      format.json { head :no_content }
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
