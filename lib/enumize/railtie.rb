# frozen_string_literal: true

module Enumize
  class Railtie < ::Rails::Railtie
    initializer "enumize.initialization" do
      ActiveRecord::Base.send(:include, Enumize::Model)
    end
  end
end
