require 'spec'
require 'stringio'

$: << File.expand_path(File.dirname(__FILE__)) + "/../../../console/lib"

[File.expand_path(File.dirname(__FILE__)) + "/../lib/tic_tac_toe_engine"].each do |path|
  require path
  $: << path
end
