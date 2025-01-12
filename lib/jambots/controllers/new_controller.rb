# frozen_string_literal: true

module Jambots
  module Controllers
    class NewController
      def initialize(options)
        @options = options
      end

      def create_bot(name)
        path = Jambots::Bot.find_path(@options[:path])
        model = @options[:model] || Jambots::Bot::DEFAULT_MODEL
        prompt = @options[:prompt]

        Jambots::Bot.create(name, path: path, model: model, prompt: prompt)
        puts "Bot '#{name}' created in '#{path}/#{name}'"
      end
    end
  end
end
