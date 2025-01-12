# frozen_string_literal: true

module Jambots
  class Conversation
    attr_accessor :messages, :file_name, :file_path, :key

    def initialize(file_path)
      @file_path = file_path
      @file_name = File.basename(file_path)
      @key = File.basename(file_name, File.extname(file_name))
      @messages = load_messages
    end

    def add_message(role, content)
      @messages << {role: role, content: content}
    end

    def save
      messages_transformed = @messages.map { |message| message.transform_keys(&:to_s) }
      File.write(@file_path, messages_transformed.to_yaml)
    end

    def load_messages
      return [] unless File.exist?(@file_path)

      file_content = File.read(@file_path)

      YAML.safe_load(file_content, permitted_classes: [Symbol], symbolize_names: true)
    end

    def delete
      File.delete(@file_path) if File.exist?(@file_path)
    end
  end
end
