# frozen_string_literal: true

require 'optparse'

module Anyway # :nodoc:
  # Initializes the OptionParser instance using the given configuration
  class OptionParserBuilder
    class << self
      def call(options)
        OptionParser.new do |opts|
          options.each do |key, descriptor|
            opts.on(*option_parser_on_args(key, **descriptor)) do |arg|
              yield [key, arg]
            end
          end
        end
      end

      private

      def option_parser_on_args(key, flag: false, desc: nil)
        on_args = ["--#{key.to_s.tr('_', '-')}#{flag ? '' : ' VALUE'}"]
        on_args << desc unless desc.nil?
        on_args
      end
    end
  end
end