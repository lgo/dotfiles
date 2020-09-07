#!/usr/bin/env ruby
# typed: false
# frozen_string_literal: true

require "optparse"

require_relative "./src/validator"
require_relative "./src/topic"
require_relative "./src/bootstrap"

module Dotfiles
  class Script
    HELP_MESSAGE = <<~EOS
      Commands:
        bootstrap   - sets up symlinks and executes all installation scripts
        info        - get information on topic(s) or script(s)

      See 'dotfiles COMMAND --help' for more information on a specific command.
    EOS

    INFO_HELP_MESSAGE = <<~EOS
      Provides information the available topic(s) or script(s). When no target is
      specified, a list of topics will be printed.

      When a topic is specified as the target, all of the documentation, symlinks,
      and scripts will be printed.

      When a script is specified as the target, the instructions and usage will be
      printed
    EOS

    def initialize
      @options = {
        only_symlinks: false,
        only_scripts: false,
      }
    end

    def parser
      OptionParser.new do |opts|
        opts.banner = "Usage: #{$0} <subcommand> [options]"
        opts.separator ""
        opts.separator HELP_MESSAGE
      end
    end

    def subcommands
      subcommands = {
        "bootstrap" => OptionParser.new do |opts|
          opts.banner = "Usage: #{$0} bootstrap [options]"
          opts.on("-s", "--only-symlinks", "Only run symlinks and not scripts") do
            @options[:only_symlinks] = true
          end
          opts.on("-s", "--only-scripts", "Only run scripts and make no symlinks") do
            @options[:only_scripts] = true
          end
        end,
        "script" => OptionParser.new do |opts|
          opts.banner = "Usage: #{$0} script [options]"
        end,
        "info" => OptionParser.new do |opts|
          opts.banner = "Usage: dotfiles info <topic:[script]>"
          opts.separator ""
          opts.separator INFO_HELP_MESSAGE
        end,
      }
    end

    def load_all_topic_paths(base_path)
      glob_path = File.join(base_path, "**", "topic.yaml")
      Dir.glob(glob_path).reject { |path| path.include?("src/schema/topic.yaml") }
    end

    def load_all_topics
      return @topics unless @topics.nil?

      validator = Dotfiles::Validator.new
      base_path = File.join(File.expand_path(__dir__))
      paths = load_all_topic_paths(base_path)
      topics = paths.select.map do |path|
        Dotfiles::Topic.read(base_path, path, validator: validator)
      end

      @topics = topics.reject(&:disabled)
      @topics
    end

    def fetch_topic(name)
      load_all_topics.find { |topic| topic.shortname == name }
    end

    def run
      parser.order!
      command = ARGV.shift&.downcase
      if command.nil?
        puts parser
        exit(0)
      elsif !subcommands.include?(command)
        puts "ERROR: #{command} is not a valid command"
        puts parser
        exit(1)
      end

      subcommand_parser = subcommands[command]
      subcommand_parser.parse!(ARGV)

      case command
      when "bootstrap"
        if ARGV.size == 0
          topics = load_all_topics
        else
          topics = ARGV.map { |topic| fetch_topic(topic) }
        end
        Dotfiles::Bootstrap.execute(topics, symlinks: !@options[:only_scripts], scripts: !@options[:only_symlinks])
      when "info"
        if ARGV.size == 0
          topics = load_all_topics
          puts "\e[1mAvailable topics\e[0m\n"
          topics.each do |topic|
            puts "#{topic.shortname}: #{topic.name}"
          end
          exit(0)
        elsif ARGV.size > 1
          puts "ERROR: please only specify one target"
          exit(1)
        end

        # FIXME(joey): info command works for topics for now.

        topic = fetch_topic(ARGV.first)
        puts "\e[1m#{topic.name} (#{topic.shortname})\e[0m"

        if topic.symlinks.size > 0
          puts "\n"
          topic.symlinks.each do |link|
            if link.is_installed?
              puts " [✅] #{link.src} -> #{link.path}"
            else
              puts " [❌] #{link.src} -> #{link.path}"
            end
          end
        end

        if topic.scripts.size > 0
          puts "\n"
          puts "Scripts"
          topic.scripts.each do |script|
            if script.bootstrap
              puts " [⚙ ] #{script.name} (#{File.join(topic.dir, script.file)})"
            else
              puts "      #{script.name} (#{File.join(topic.dir, script.file)})"
            end
          end
        end

        puts "\n(from #{topic.absolute_dir})"
      end
    end
  end
end

if __FILE__ == $0
  Dotfiles::Script.new.run
end
