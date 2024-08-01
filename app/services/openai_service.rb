# app/services/openai_service.rb

require "openai"

class OpenaiService
  def initialize
    @client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
  end

  def generate_cover_letter(resume, job_description)
    prompt = "Generate a concise, one-page cover letter based on the following guidelines:
  1. Analyze the user's resume and job posting.
  2. Create a tailored cover letter highlighting 3-4 most relevant experiences and skills.
  3. Optimize for ATS keywords.
  4. Focus on unique connections between the candidate and job. Avoid resume repetition and generic phrases.
  5. Keep the letter brief - aim for 250-300 words maximum.

  Resume: #{resume}
  Job Posting: #{job_description}

  Generate the cover letter now."

    response = @client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{ role: "user", content: prompt }],
        temperature: 0.7,
        max_tokens: 400,
        presence_penalty: 0.5,
        frequency_penalty: 0.5,
      },
    )

    content = response.dig("choices", 0, "message", "content")
    return content
  end

  def highlight_cover_letter(cover_letter, resume, job_description)
    prompt = "Aggressively highlight the cover letter content:
  1. Aim to highlight 70-80% of the text.
  2. Use <span class='resume-highlight'> for resume-related content.
  3. Use <span class='job-highlight'> for job posting-related content.
  4. Highlight entire sentences or phrases, not just individual words.
  5. If a phrase relates to both resume and job, prioritize job highlighting.
  6. Do not alter the original text, only add highlighting tags.

  Cover Letter: #{cover_letter}
  Resume: #{resume}
  Job Posting: #{job_description}

  Return the heavily highlighted cover letter."

    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }],
        temperature: 0.2,
        max_tokens: 600,
        presence_penalty: 0.1,
        frequency_penalty: 0.1,
      },
    )

    content = response.dig("choices", 0, "message", "content")
    return content
  end

  def generate_highlighted_cover_letter(resume, job_description)
    cover_letter = generate_cover_letter(resume, job_description)
    highlighted_cover_letter = highlight_cover_letter(cover_letter, resume, job_description)
    return highlighted_cover_letter
  end
end
