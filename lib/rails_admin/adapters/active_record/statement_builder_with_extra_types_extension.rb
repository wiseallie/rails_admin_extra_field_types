require 'rails_admin/adapters/active_record'
module RailsAdmin
  module Adapters
    module ActiveRecord
      module StatementBuilderWithExtraTypesExtension
        def self.included(base)
          base.class_eval do
            alias_method_chain :build_statement_for_type, :extra_types
          end
        end

        private

        def build_statement_for_type_with_extra_types
          case @type
          when :boolean                   then build_statement_for_boolean
          when :integer, :decimal, :float then build_statement_for_integer_decimal_or_float
          when :string, :text             then build_statement_for_string_or_text
          when :citext                    then build_statement_for_string_or_text
          when :uuid                      then build_statement_for_uuid
          when :enum                      then build_statement_for_enum
          when :belongs_to_association    then build_statement_for_belongs_to_association
          end
        end

        def build_statement_for_type
          build_statement_for_type_with_extra_types
        end

        def build_statement_for_uuid
          return if @value.blank?
          @value = begin
            case @operator
            when 'default', 'like'
              "%#{@value.downcase}%"
            when 'starts_with'
              "#{@value.downcase}%"
            when 'ends_with'
              "%#{@value.downcase}"
            when 'is', '='
              "#{@value.downcase}"
            else
              return
            end
          end

          if ar_adapter == 'postgresql'
            ["(#{@column}::text ILIKE ?)", @value]
          else
            ["(LOWER(CAST(#{@column} AS VARCHAR(50))) LIKE ?)", @value.to_s.downcase]
          end
        end
      end
    end
  end
end

if RUBY_VERSION >= '2.0.0'
  RailsAdmin::Adapters::ActiveRecord::StatementBuilder.send(:prepend, RailsAdmin::Adapters::ActiveRecord::StatementBuilderWithExtraTypesExtension)
else
  RailsAdmin::Adapters::ActiveRecord::StatementBuilder.send(:include, RailsAdmin::Adapters::ActiveRecord::StatementBuilderWithExtraTypesExtension)
end
