require 'rake'
require 'spec/rake/spectask'

desc "Run all examples"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList["console/spec/**/*_spec.rb", "game_engine/spec/**/*_spec.rb",
                          "limelight/spec/**/*_spec.rb"]
  t.libs = ["console/lib", "game_engine/lib", "limelight/lib"]
  t.spec_opts = ["--format specdoc"]
end

task :default => :spec
