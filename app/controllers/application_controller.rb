class ApplicationController < ActionController::Base
  include Orderable
  allow_browser versions: :modern
end
