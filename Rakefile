require 'rake'
require 'spec/rake/spectask'

desc "Run all examples"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList["console/spec/**/*_spec.rb", "vendor/tic_tac_toe_engine/spec/**/*_spec.rb",
                          "limelight/spec/**/*_spec.rb", "webrick/spec/**/*_spec.rb"]
  t.libs = ["console/lib", "vendor/tic_tac_toe_engine/lib", "limelight/lib", "webrick/lib"]
  t.spec_opts = ["--format specdoc"]
end

task :default => :spec
