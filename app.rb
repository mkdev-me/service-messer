require 'sinatra'
require 'k8s-ruby'

get '/frank-says' do
  client = K8s::Client.in_cluster_config

  client.api('apps/v1').resource('deployments').list
end
