# app/services/openai_service.rb
require "openai"

class OpenaiService
  def initialize
    @client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
  end

  def generate_cover_letter(resume, job_description)
    prompt = "Generate a unique and tailored cover letter based on the following:
      
    - Resume highlights & personal info: #{resume}
    - Job requirements: #{job_description}
      
    Make the letter specific to this candidate and job. 
    Highlight how the candidates experience directly relates to the job requirements. 
    Avoid generic phrases. 
    Be creative and original."

    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }],
        temperature: 0.9,
        top_p: 0.95,
        max_tokens: 500,
        presence_penalty: 0.6,
        frequency_penalty: 0.6,
      },
    )

    response.dig("choices", 0, "message", "content")

    # Example Resume
    #-------------------------------------------------------------------------------------------------#
    # Jan Niewielski
    # Chicago, IL  |  773-751-8655  |  jann.developer@gmail.com  |  LinkedIn  |  Github  |  Portfolio

    # EDUCATION
    # Discovery Partners Institute - Chicago, IL 							       	           May 2024 – Present
    # Software Developer Apprentice Trainee
    # •	Focused on fundamental concepts of the Rails framework to develop dynamic web applications with Ruby.
    # •	Mapped out relationships between different data entities utilizing entity relationship diagrams (ERDs).
    # •	Created and merged branches‚ performed code reviews‚ and utilized version control on Github.
    # •	Enhanced reading‚ writing‚ and communication skills through maintaining thorough documentation.
    # •	Used Rails generators to streamline development process‚ as well as the implementation of user accounts and authentication in applications.
    # Northeastern Illinois University - Chicago, IL
    # Bachelor of Science in Computer Science

    # PROJECTS
    # SimilarSongs - (Ruby, HTML, CSS, Render)
    # •	Developed a dynamic web application using Ruby on Rails that allows users to discover similar songs based on their input.
    # •	Designed and built a responsive frontend using HTML and CSS, ensuring a seamless user experience across devices.
    # •	Deployed the application on Render, setting up continuous integration and deployment pipelines.

    # KickGalaxy - (HTML, CSS, Ruby)
    # •	Built a fully functional mock e-commerce website inspired by Foot Locker.
    # •	Implemented features like product browsing, filtering, and a shopping cart to simulate a real-world shopping experience.
    # •	Utilized responsive design principles to ensure the website adapts seamlessly to various screen sizes and devices.

    # PROFESSIONAL EXPERIENCE
    # Friedler Construction Co. - Chicago, IL 						          		 April 2022 - January 2023
    # Assistant Project Manager
    # •	Gained proficiency in project management tools (Procore, eBuilder) within 1-2 months through self-learning and motivation, resulting in boosted productivity and strengthening problem-solving abilities.
    # •	Coordinated for 40+ Chicago Public School projects concurrently, ensuring smooth collaboration with senior leadership and project subcontractors.
    # •	Maintained project alignment with scope, budget, and schedules, reducing total project duration by 25% through proactive enforcement of due dates and handling project changes.
    # •	Reduced project wait times by 40% through close monitoring of project progress and fostering strong relationships between clients and internal teams.
    # •	Authorized 30+ project changes on a weekly basis with keen attention to detail, keeping contact information up-to-date, and optimized organization of emails by subcategories.
    # Ridgemoor Country Club - Harwood Heights, IL		          			            		   March 2014 - April 2024
    # Golf Caddy & Staff Member
    # •	Leveraged communication skills and situational awareness to provide tailored advice to 250+ club members, resulting in a 40% increase in customer satisfaction and demonstrating ability to analyze complex situations and deliver clear, actionable insights.
    # •	Utilized bilingual skills to cultivate new client relationships and enhance existing ones, broadening the client base and reinforcing client loyalty.

    # SKILLS
    # Full Stack: HTML, CSS, JavaScript, Ruby on Rails, Git, RESTful APIs, PostgreSQL
    # Server-Side Programming: Ruby, Python, Java
    # Development Tools: Visual Studio Code, GitHub, Codepen, Webflow, Render
    # Other: Microsoft Office Suite, Agile methodology, Object-Oriented Programming
    # Bilingual: English and Polish
    #-------------------------------------------------------------------------------------------------#

    # Example Job Description
    #-------------------------------------------------------------------------------------------------#
    # About the job
    # In this age of disruption, organizations need to navigate the future with confidence by tapping into the power of data analytics, robotics, and cognitive technologies such as Artificial Intelligence (AI). Our Strategy & Analytics portfolio helps clients leverage rigorous analytical capabilities and a pragmatic mindset to solve the most complex of problems. By joining our team, you will play a key role in helping to our clients uncover hidden relationships from vast troves of data and transforming the Government and Public Services marketplace.

    # Work You'll Do
    # The Full Stack Developer will work as part of a cross-functional agile team to launch innovative AI-driven Data and Analytics products for Public Sector clients. In addition, the developer will:
    # Collaborate with team of full-stack engineers to design and develop software products that transform global mission
    # Leverage modern Javascript frameworks such as Angularjs or React
    # Engineer application software solutions using application frameworks such as Spring, JQuery, and web application servers such as Apache, WildFly (JBoss), Tomcat, WebLogic, or WebSphere.
    # Achieve sprint goals with a team of world-class back-end engineers
    # Understand Deloitte's strategic and competitive position and deliver products that are recognized as cutting-edge and best in the industry

    # The Team
    # Deloitte's Government and Public Services (GPS) practice - our people, ideas, technology and outcomes-is designed for impact. Serving federal, state, & local government clients as well as public higher education institutions, our team of over 15,000+ professionals brings fresh perspective to help clients anticipate disruption, reimagine the possible, and fulfill their mission promise.
    # The GPS Analytics and Cognitive (A&C) offering is responsible for developing advanced analytics products and applying data visualization and statistical programming tools to enterprise data in order to advance and enable the key mission outcomes for our clients. Our team supports all phases of analytic work product development, from the identification of key business questions through data collection and ETL, and from performing analyses and using a wide range of statistical, machine learning, and applied mathematical techniques to delivery insights to decision-makers. Our practitioners give special attention to the interplay between data and the business processes that produce it and the decision-makers that consume insights.

    # Qualifications
    # Required:
    # 2+ years demonstrated expertise backend software engineering (Java/Spring/Node.js)
    # 2+ years demonstrated expertise frontend software engineering (JavaScript/Angular/React)
    # Bachelor's degree required
    # Must be legally authorized to work in the United States without the need for employer sponsorship, now or at any time in the future
    # Must be able to obtain/maintain active security clearance

    # Preferred
    # Creativity and innovation - desire to learn and apply new technologies, products, and libraries.
    # Strong knowledge of best practices - willingness to review code and provide feedback to other engineers
    # Experience implementing wireframes with flexible, well-structured code
    # Willingness to collaborate with distributed teams
    # Comfortable with code versioning tools such as Git
    #-------------------------------------------------------------------------------------------------#

  end
end
