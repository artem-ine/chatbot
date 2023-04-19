require '../lib/chatbot_glace.rb'

describe "The list me 5 flavors" do
  it "should return 5 elements" do
      response_string = "flavor1,flavor2,flavor3,flavor4,flavor5"
      expect(response_string).to match(/^\w+(,\w+){4}$/)
  end
end