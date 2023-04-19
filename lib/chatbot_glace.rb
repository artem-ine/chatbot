require 'pry'
require 'http'
require 'json'
require 'dotenv'

Dotenv.load('.env')


def login_openai

  Dotenv.load('.env')
  api_key = ENV["OPENAI_API_KEY"]
  url = "https://api.openai.com/v1/engines/text-babbage-001/completions"

  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}"
  }

  data = {
    "prompt" => "5 ice creams flavor",
    "max_tokens" => 50,
    "temperature" => 0.3,
    "n" => 1,
  }

  response = HTTP.post(url, headers: headers, body: data.to_json)
  response_body = JSON.parse(response.body.to_s)
  response_string = response_body["choices"][0]["text"].strip
  
  return response_string
end



# ligne qui permet d'envoyer l'information sur ton terminal
puts "Here's 5 ice cream flavors :"
puts login_openai