require 'sinatra'
require 'k8s-ruby'
require 'sequel'
require 'uri'
require 'net/http'

unless ENV["DB_URL"].nil?
  DB = Sequel.connect(ENV["DB_URL"])
end

get '/coin-flipper' do
  code = rand(200..599)
  status code
  "Code: #{code}"
end

get '/ping' do
  excluded_namespaces = Array(params['exclude'].to_s.split(","))

  client = K8s::Client.in_cluster_config

  client.api('v1').resource('services').list.each do |svc|
    next if excluded_namespaces.include?(svc.metadata.namespace)
    svc.spec.ports.each do |p|
      uri = URI("http://#{svc.metadata.name}.#{svc.metadata.namespace}:#{p.port}")
      puts "Pinging #{uri}"
      res = Net::HTTP.get_response(uri)
      puts res.inspect
    end
  end
end

get '/add-message/:message' do
  messages = DB[:messages] # Create a dataset
  messages.insert(:message => params['message'])

  "Total messages: #{messages.count}"
end

get '/messages' do
  messages = DB[:messages] # Create a dataset
  messages.map { |m| "<p>#{m[:id]}: #{m[:message]}</p>" }
end
