# app/services/openai_service.rb

require "openai"

class OpenaiService
  def initialize
    @client = OpenAI::Client.new({ :access_token => ENV.fetch("OPENAI_API_KEY") })
  end

  def generate_cover_letter(resume, job_description)
    prompt = "Generate a tailored cover letter based on the following:
    
    - Resume highlights: #{resume}
    - Job requirements: #{job_description}
    
    Focus on unique aspects that connect the user to the job, rather than repeating resume details. Highlight the candidate's experience that directly relates to the job requirements. Avoid generic phrases and be creative.
    
    Wrap resume aspects in <span class='resume-highlight'> tags and job description aspects in <span class='job-highlight'> tags."

    response = @client.chat(
      {
        :parameters => {
          :model => "gpt-3.5-turbo",
          :messages => [{ :role => "user", :content => prompt }],
          :temperature => 0.9,
          :top_p => 0.95,
          :max_tokens => 500,
          :presence_penalty => 0.6,
          :frequency_penalty => 0.6,
        },
      }
    )

    return response.dig("choices", 0, "message", "content")
  end
end
