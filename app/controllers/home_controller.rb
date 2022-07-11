class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[ home ]
  def index; end

  def home; end
end
