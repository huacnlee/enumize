# frozen_string_literal: true

class Book < ApplicationRecord
  enum status: %i{draft published archived}
end
