require "vinerb/version"
require "vinerb/error"
require 'vinerb/endpoints'
require "vinerb/model"
require "vinerb/api"

module Vinerb

  extend self

  def login(email, password)
    Model::User.login(email, password)
  end

  def signup(email, password, full_name)
    Model::User.signup(email, password, full_name)
  end


end
