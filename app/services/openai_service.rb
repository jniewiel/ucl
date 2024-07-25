# app/services/openai_service.rb
require "openai"

class OpenaiService
  def initialize
    @client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
  end

  def generate_cover_letter(resume, job_description)
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # or your chosen model
        messages: [{ role: "user", 
                    content: "Generate a cover letter based on this resume: #{resume} and this job description: #{job_description}" }],
        temperature: 0.7,
      })
    
      response.dig("choices", 0, "message", "content")
  end
end
