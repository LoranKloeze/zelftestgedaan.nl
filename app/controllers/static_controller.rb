class StaticController < ApplicationController
  def thanks
  end

  def privacy
  end

  def too_soon
  end

  def fake_exception
    raise "This is a fake exception"
  end
end
