class ApplicationController < ActionController::Base
  include Noticable
  protect_from_forgery prepend: true
end
