#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

TESTCASE = 'dsl_app_border_007'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    height 10
    log '/tmp/vedeu_views_dsl.log'
    renderers [
                Vedeu::Renderers::Terminal.new(
                  filename: "/tmp/#{TESTCASE}.out",
                  write_file: true),
                # Vedeu::Renderers::JSON.new(filename: "/tmp/#{TESTCASE}.json"),
                # Vedeu::Renderers::HTML.new(filename: "/tmp/#{TESTCASE}.html"),
                # Vedeu::Renderers::Text.new(filename: "/tmp/#{TESTCASE}.txt"),
              ]
    run_once!
    standalone!
  end

  load File.dirname(__FILE__) + '/support/test_interface.rb'

  Vedeu.border :test_interface do
    foreground '#ff5722'
    top_horizontal    '*', colour: { background: '#000000', foreground: '#ffffff' }
    left_vertical     '$', colour: { background: '#0000ff', foreground: '#ffffff' }
    right_vertical    '%', colour: { background: '#ffff00', foreground: '#000000' }
    bottom_horizontal '&', colour: { background: '#ffffff' }
  end

  Vedeu.render do
    view(:test_interface) do
      lines do
        line 'custom'
        line 'edges'
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start

load File.dirname(__FILE__) + '/test_runner.rb'
TestRunner.result(TESTCASE, __FILE__)