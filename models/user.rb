# frozen_string_literal: true

# The information
class User < Struct.new(:id, :name_one, :name_two, :number, :rate, :min, keyword_init: true)
end
