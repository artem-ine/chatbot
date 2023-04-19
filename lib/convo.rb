require 'openai'
require 'pry'
require 'http'
require 'json'
require 'dotenv'

Dotenv.load('.env')


# Set up the OpenAI API client
OpenAI.api_key = "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"
api = OpenAI::API.new

# Define a method to handle user input
def handle_user_input(prompt, api)
  # Send the user's input to the OpenAI API
  response = api.completions.create(
    engine: "davinci",
    prompt: prompt,
    max_tokens: 50,
    n: 1,
    stop: "\n"
  )
  
  # Return the AI's response
  response.choices.first.text.strip
end

# Start the conversation
puts "Hi, how can I help you today?"
loop do
  print "> "
  user_input = gets.chomp
  
  # Add the user's input to the prompt
  prompt = "User: #{user_input}\nBot:"
  
  # Get the AI's response
  bot_response = handle_user_input(prompt, api)
  
  # Print the AI's response
  puts bot_response
end