# frozen_string_literal: true

require "hanami/cli/commands/gem/new"

RSpec.describe Hanami::CLI::Commands::Gem::New do
  subject { described_class.new(bundler: bundler, out: stdout, fs: fs) }

  let(:bundler) { instance_double(Hanami::CLI::Bundler, install!: true) }
  let(:stdout) { StringIO.new }
  let(:fs) { RSpec::Support::FileSystem.new }
  let(:app) { "bookshelf" }

  it "normalizes app name" do
    app_name = "PropagandaLive"
    app = "propaganda_live"
    subject.call(app: app_name)

    expect(fs.directory?(app)).to be(true)
  end

  context "architecture: unknown" do
    let(:architecture) { "unknown" }

    it "raises error" do
      expect do
        subject.call(app: app, architecture: architecture)
      end.to raise_error(ArgumentError, "unknown architecture `#{architecture}'")
    end
  end
end