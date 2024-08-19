# UCL (Unique Cover Letter) Generator

![UCL-Landing](https://github.com/user-attachments/assets/aee8d793-6d5b-4e14-847e-896762f6ac4b)


## Description

The UCL (Unique Cover Letter) Generator is an AI-powered tool designed to streamline the job application process by automatically creating tailored cover letters. By analyzing your resume and the job posting, this application generates personalized cover letters that highlight your most relevant skills and experiences.


## Table of Contents
- [Features](#features)
- [User Stories](#user-stories)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [FAQ](#faq)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)


## Features

- **Resume Parser**: Extracts key information from your professional profile
- **Job Posting Analyzer**: Scans job descriptions to identify key requirements and desired skills
- **AI-Powered Writing**: Generates a draft cover letter emphasizing your relevant qualifications
- **Edit and Refine**: Interface for users to modify and improve the generated letter
- **Skill Matching**: Compares your skills and experience with job requirements
- **Keyword Optimization**: Incorporates industry-specific keywords to improve ATS compatibility
- **Multiple Versions**: Can create various cover letter options for you to choose from


## User Stories

- Generate a base letter for easy personalization
- Edit and further customize the generated cover letter
- Create compelling cover letters for recent graduates with limited experience
- Analyze transferable skills for career changers
- Quickly generate multiple versions for different job applications


## Installation

1. Clone the repository:
`git clone https://github.com/jniewiel/ucl.git`

2. Navigate to the project directory:
`cd ucl`

3. Install the required gems:
`bundle install`

4. Set up the database:
`rails db:setup`

5. Start the Rails server:
`bin/dev`

6. Open Port 3000 server.


## Configuration

To use this project, you need to set up your OpenAI API key as an environment variable:

1. Obtain an API key from [OpenAI](https://openai.com/api/).
2. Set the environment variable:

   ```bash
   export OPENAI_API_KEY=your_api_key_here
   ```


## Usage

1. Log in / sign up for account.

2. Paste resume into designated "Resume" text area.

5. Paste job description into designated "Job Description" text area.

6. Click on "Generate Cover Letter" button to create tailored cover letter.

7. Options:
    - Click "Generate Cover Letter" button again to re-generate new cover letter.
    - Click "Copy Clipboard" to copy cover letter text to clipboard.
    - Click "Save Cover Letter" to save to your account for later use or reference.
    - Click "Clear Form" to refresh a new, clean page.


## FAQ

**Q: What files affect the look and layout of UCL? (ex. web pages, landing page, etc.)**

A: All of those files can be found under `app/views`.

**Q: How can I access my database?**

A: While on a server, in your URL: replace the end with `rails/db`. That will send you to a Rails link that you can access your local server's database.

**Q: Why is there an error message when trying to generate my cover letter?**

A: Please check that your API key is functional, your OpenAI account has enough funds, and/or everything is functional in `app/services/openai_service.rb`.


## Entity-Relationship Diagram (ERD)

<img width="661" alt="UCL-ERD" src="https://github.com/user-attachments/assets/64618f8a-6567-4a90-b692-706e23597f76">


## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository

2. Create a new branch (`git checkout -b feature-branch`)

3. Commit your changes (`git commit -m 'Add some feature'`)

4. Push to the branch (`git push origin feature-branch`)

5. Open a pull request


## License

Distributed under the MIT License. See `LICENSE` for more information.


## Contact

Jan Niewielski - [jann.developer@gmail.com](mailto:jann.developer@gmail.com)

Project Link: [https://github.com/users/jniewiel/projects/1](https://github.com/users/jniewiel/projects/1)

<!--
## Acknowledgements

(Any acknowledgements or credits will be added here)
-->
