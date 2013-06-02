# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'motion-cocoapods'
require 'afmotion'
require 'motion-frank'
require 'motion-stump'
require 'motion-testflight'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'cyrus-snaps'
  app.frameworks = ['CoreLocation', 'MapKit']

  puts "Setting BASE_URL to #{ENV['BASE_URL']}"
  app.info_plist['BASE_URL'] = ENV['BASE_URL']

  # TestFlight
  app.testflight.sdk = 'vendor/TestFlight'
  app.testflight.api_token = ENV['TESTFLIGHT_API_TOKEN']
  app.testflight.team_token = ENV['TESTFLIGHT_TEAM_TOKEN']
  app.testflight.app_token = ENV['TESTFLIGHT_APP_TOKEN']
  app.testflight.identify_testers = true

  app.pods do
    pod 'AFNetworking'
  end
end

desc "Open latest crash log"
task :log do
  app = Motion::Project::App.config
  exec "less '#{Dir[File.join(ENV['HOME'], "/Library/Logs/DiagnosticReports/#{app.name}*")].last}'"
end
