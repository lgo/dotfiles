#!/usr/bin/env ruby
# typed: true
# frozen_string_literal: true

require "yaml"
require "pathname"
require "io/console"
require "fileutils"
require "tmpdir"

module Dotfiles
  module Bootstrap
    def self.prompt
      case $stdin.getch
      when "b" then :backup
      when "o" then :overwrite
      when "s" then :skip
      else nil
      end
    end

    def self.log_info(msg)
      puts " [ \033[00;34m..\033[0m ] #{msg}\n"
    end

    def self.log_user(msg)
      puts " [ \033[0;33m??\033[0m ] #{msg}\n"
    end

    def self.prompt_user(msg)
      puts "        #{msg}\n"
      result = prompt
      if result.nil?
        puts "Invalid character. (one more attempt)\n"
        result = prompt
      end
      if result.nil?
        raise ArgumentError.new("provided invalid character")
      end
      result
    end

    def self.log_success(msg)
      puts "\033[2K [ \033[00;32mOK\033[0m ] #{msg}\n"
    end

    def self.log_failure(msg)
      puts "\033[2K [\033[0;31mFAIL\033[0m] #{msg}\n"
    end

    def self.install_symlink!(topic, symlink)
      src_path = Pathname.new(topic.dir).join(symlink.src).to_s
      dest_basedir = Pathname.new(symlink.path).dirname.to_s
      dest_path = symlink.path
      dest_absolute_path = File.expand_path(symlink.path)

      result = nil

      if symlink.is_installed?
        log_success("#{symlink.src} already linked")
        return
      elsif symlink.has_conflict?
        if FileTest.symlink?(dest_absolute_path)
          current_link_destination = File.readlink(dest_absolute_path)
          log_user("#{symlink.src} will overwrite existing link #{dest_path} (-> #{current_link_destination})")
        else
          log_user("#{symlink.src} will overwrite existing file: #{dest_path}")
        end
        result = prompt_user("what do you want to do? [\e[1ms\e[0m]kip, [\e[1mo\e[0m]verwrite, [\e[1mb\e[0m]ackup to .bak?")
        case result
        when :skip
          log_info("skipping #{symlink.src}")
          return
        when :overwrite
          log_info("overwriting #{dest_path}")
          if File.directory?(dest_absolute_path)
            FileUtils.rmdir(dest_absolute_path)
          else
            File.delete(dest_absolute_path)
          end
        when :backup
          log_info("created #{dest_path}.bak")
          FileUtils.mv(dest_absolute_path, dest_absolute_path + ".bak")
        end
      end

      FileUtils.mkdir_p(File.expand_path(dest_basedir))
      File.symlink(src_path, dest_absolute_path)
      log_success("#{symlink.src} linked")
    end

    def self.run_script!(topic, script)
      log_info("running script: #{script.name}")
      log_folder = File.join(@@tempdir, "logs", topic.shortname)
      FileUtils.mkdir_p(log_folder)
      log_path = File.join(log_folder, script.file.gsub(/\./, "_") + ".log")
      result = system("#{script.full_path} 2>&1 1>#{log_path}")
      if result
        log_success("finished script")
      else
        @@had_failure = true
        log_failure("failed script. see the logs at: #{log_path}")
      end
    end

    def self.bootstrap(topic, symlinks:, scripts:)
      puts " [ ⚙  ] bootstrapping #{topic.name} (#{topic.shortname})"
      if symlinks
        topic.symlinks.each do |symlink|
          install_symlink!(topic, symlink)
        end
      end

      if scripts
        topic.scripts.each do |script|
          if script.bootstrap
            run_script!(topic, script)
          end
        end
      end
      puts " [ ✅ ] completed #{topic.name} (#{topic.shortname})"
    end

    def self.execute(topics, symlinks:, scripts:)
      @@tempdir = Dir.mktmpdir
      @@had_failure = true

      # We care about installation ordering, such as installing macos first.
      macos_topic = topics.find { |topic| topic.shortname == "macos" }
      if macos_topic
        bootstrap(macos_topic, symlinks: symlinks, scripts: scripts)
      end
      topics.reject { |topic| topic.shortname == "macos" }.each do |topic|
        bootstrap(topic, symlinks: symlinks, scripts: scripts)
      end

      # Clean up the temp directory if there were no failures.
      if !@@had_failure
        FileUtils.remove_entry(@@tempdir)
      end
    end
  end
end
