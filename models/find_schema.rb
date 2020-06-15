# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'
require_relative 'rate_type'

FindNewSchema = Dry::Schema.Params do
  required(:number).filled(:integer)
  required(:name_f).filled(:string)
end