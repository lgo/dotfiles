#!/usr/bin/env ruby
# typed: false

require_relative './library/Rx'
require 'yaml'

module Dotfiles
  class Validator
    def initialize
      @rx = Rx.new({ :load_core => true })
      schemas = load_schemas
      schemas.each do |path, yaml|
        if is_meta_schema?(yaml)
          begin
            @rx.learn_type(yaml['uri'], yaml['schema'])
          rescue Exception => e
            puts "An error occurred learning Rx meta scheme #{yaml['uri']}"
            raise
          end
        end
      end

      _, topic_yaml = schemas.find {|path, _| path =~ /schema\/topic\.yaml/}
      begin
        @topic_schema = @rx.make_schema(topic_yaml)
      rescue Exception => e
        puts "An error occured while loading the Rx topic schema"
        raise
      end
    end

    def is_meta_schema?(yaml)
      yaml.include?('uri') && yaml.include?('schema')
    end

    def load_schemas
      schema_glob = File.join(File.expand_path(__dir__), "schema/*.yaml")
      paths = Dir.glob(schema_glob)
      paths.map do |path|
        file = File.open(path).read
        [path, YAML.load(file)]
      end.to_h
    end

    def load_and_check!(path)
      yaml = YAML.load_file(path)
      @topic_schema.check!(yaml)
      yaml
    end
  end
end