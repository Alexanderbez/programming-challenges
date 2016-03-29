$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kevin_bacon/graph'
require 'minitest/autorun'
require 'minitest/reporters'

# Inject Minitest Reporters
Minitest::Reporters.use! [
  Minitest::Reporters::SpecReporter.new,
  Minitest::Reporters::MeanTimeReporter.new
]
