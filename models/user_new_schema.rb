# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'
require_relative 'rate_type'

UserNewSchema = Dry::Schema.Params do
  required(:name_one).filled(SchemaTypes::StrippedString)
  required(:name_two).filled(SchemaTypes::StrippedString)
  required(:rate).filled(SchemaTypes::StrippedString, included_in?: RateType.all_types)
end
