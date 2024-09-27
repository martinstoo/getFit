# getFit

## Willkommen! 
getFit, der innovativen Fitness-App, die Coaches und Trainierende zusammenbringt! Coaches können hier ganz einfach individuelle Trainingspläne erstellen und zur Verfügung stellen. Trainierende haben direkten Zugriff auf unterschiedliche Trainings, um ihre Fitnessziele effektiv zu erreichen. Egal ob Anfänger oder Profi – getFit unterstützt dich auf deinem Weg zu mehr Fitness und ein gesundes Leben!


## Short Technical Description
This is a Ruby on Rails application that manages training and exercise sessions for users. It supports three types of users: Admin, Coach, and Student. Admins can manage all resources, while Coaches and Students have restricted access to their own resources.

## Technologies Used

- Ruby on Rails
- Devise
- RSpec
- SQLite3

## Installation

To get started with this application, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/martinstoo/getFit.git
   cd getFit

2. **Install Gems**
   
   ```bash
   bundle install

3. **Create and migrate database**
   
   ```bash
   rails db:create
   rails db:migrate
   
3. **Run server**
    ```bash
   rails server

4. **Testing**
   ```bash
   bundles exec rspec