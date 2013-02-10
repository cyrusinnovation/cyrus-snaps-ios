# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bubble-wrap/core'
require 'bubble-wrap/http'
require 'uri'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'cyrus-snaps'
  app.frameworks = ['CoreLocation', 'MapKit']
end

desc "Open latest crash log"
task :log do
  app = Motion::Project::App.config
  exec "less '#{Dir[File.join(ENV['HOME'], "/Library/Logs/DiagnosticReports/#{app.name}*")].last}'"
end
