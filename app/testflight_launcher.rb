# This file is automatically generated. Do not edit.

if Object.const_defined?('TestFlight') and !UIDevice.currentDevice.model.include?('Simulator')
  NSNotificationCenter.defaultCenter.addObserverForName(UIApplicationDidBecomeActiveNotification, object:nil, queue:nil, usingBlock:lambda do |notification|
  TestFlight.setDeviceIdentifier(UIDevice.currentDevice.uniqueIdentifier)
  TestFlight.takeOff('8e420e66-6496-4865-8b7c-fdccf6493fec')
  end)
end
