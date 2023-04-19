require 'pry'
require 'http'
require 'json'
require 'dotenv'

Dotenv.load('.env')

def start
  puts "Your turn to say something:"
  print "> "
  prompt = gets.chomp
  return prompt
end

def login_openai(prompt)
  Dotenv.load('.env')
  api_key = ENV["OPENAI_API_KEY"]
  url = "https://api.openai.com/v1/engines/text-babbage-001/completions"

  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}"
  }

  data = {
    "prompt" => prompt,
    "max_tokens" => 200,
    "temperature" => 0.35,
    "n" => 1,
  }

  response = HTTP.post(url, headers: headers, body: data.to_json)
  response_body = JSON.parse(response.body.to_s)
  response_string = response_body["choices"][0]["text"].strip

  return response_string
end

def conversation
  conversation_history = []

  loop do
    prompt = start
    break if prompt == "exit"

    # Add the user's input to the conversation history
    conversation_history << {user: prompt}

    # Generate the chatbot's response
    if conversation_history.size >= 2 && conversation_history[-2][:user].include?(prompt)
      chatbot_response = "I know about this. #{login_openai(prompt)}"
    else
      chatbot_response = "#{login_openai(prompt)}"
    end

    chatbot_response = login_openai(prompt)
    puts chatbot_response

    # Add the chatbot's response to the conversation history
    conversation_history << {chatbot: chatbot_response}
  end
end

conversation