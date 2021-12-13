# frozen_string_literal: true

require 'thor'

class Docker < Thor
  include Thor::Actions

  def self.exit_on_failure?
    true
  end

  desc 'build', 'Build docker images'
  option :push, description: 'Push image to docker registry', type: :boolean, aliases: :p
  def build(context, target = nil, version = nil)
    target ||= context
    raise ArgumentError, "Context: \"#{context}\" is not valid. Valid contexts are ci or health." unless ['ci', 'health'].include?(context)
    raise ArgumentError, "Target: \"#{target}\" is not valid. Valid targets are ci, e2e or health." unless ['ci', 'e2e', 'health'].include?(target)

    ruby_version = ENV['RUBY_VERSION'] || '3.0.3'
    node_version = ENV['NODE_VERSION'] || '16'
    bundler_version = ENV['BUNDLER_VERSION'] || '2.2.32'
    project_name = ENV['PROJECT_NAME'] || 'fleetyards'

    inside(context) do
      run("docker build -t #{project_name}/#{target}:#{version || ruby_version} --target=#{target} --build-arg RUBY_VERSION=#{ruby_version} --build-arg NODE_VERSION=#{node_version} --build-arg BUNDLER_VERSION=#{bundler_version} .")

      run("docker push #{project_name}/#{target}:#{version || ruby_version}") if options[:push]
    end
  end
end
