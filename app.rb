require 'rubygems'
require 'sinatra'
require 'twilio'

get '/' do
  'Welcome!'
end

post '/start' do
  return Twilio::Verb.new do |v|
    v.say("Welcome!  Enter your pin!")
    v.gather(:action => '/join', :timeout => 10)
  end.response
end

post '/join' do
  return Twilio::Verb.new do |v|
    v.say("Joining #{params['Digits']}")
    v.dial {
      v.conference(params['Digits'])
    }
  end.response
end
