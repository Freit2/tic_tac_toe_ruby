require 'rubygems'
require 'spec'
require 'limelight/specs/spec_helper'
require 'stringio'

$: << File.expand_path(File.dirname(__FILE__)) + "/../lib"

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../")
