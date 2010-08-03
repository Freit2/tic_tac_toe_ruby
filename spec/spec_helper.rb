require 'rubygems'
require 'spec'
require 'limelight/specs/spec_helper'
require 'stringio'

$: << File.expand_path(File.dirname(__FILE__)) + "/../lib"
$: << File.expand_path(File.dirname(__FILE__)) + "/../web"

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../")
