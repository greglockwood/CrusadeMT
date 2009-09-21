namespace :db do
  namespace :populate do
    australian_states = [["Australian Capitol Territory", "ACT"], 
    ["New South Wales", "NSW"], 
    ["Northern Territory", "NT"], 
    ["South Australia","SA"], 
    ["Tasmania","TAS"], 
    ["Victoria","VIC"],
    ["Western Australia","WA"]]
    
    desc "Erase and fill default values for Australian states"
    task :states => :environment do
      State.delete_all
      australian_states.each do |name,abbrev|
        State.create({:name => name, :abbreviation => abbrev})
      end
    end
    
    desc "Erase and fill database with sample data, slightly randomized"
    task :sample_data => :environment do
      require 'populator'
      require 'faker'
      
      [FieldMinistry, Client, Church, Degree, Enrolment, FieldMinistryInvolvement, LifeEvent, Person, School, State, Student, Workplace].each(&:delete_all)
      
      ministries = ["Student Life", "Athletes In Action", "Family Life", "Children of the World", "Youth Ministry", "CRAM"]
      current_ministry = 0
      current_state = 0
      
      # keep track of ids of records created so we can assign them properly later
      state_ids = []
      primary_school_ids = [] 
      high_school_ids = []
      university_ids = []
      church_ids = [nil] # should mean when randomly picked from that it can be nil
      people_ids = []
      adult_ids = []
      young_adult_ids = []
      child_ids = []
      workplace_ids = [nil]
      
      
      # create the non-nested sample models to use, like universities and workplaces
      # states
      State.populate 7 do |state|
        state.name = australian_states[current_state].first
        state.abbreviation = australian_states[current_state].last
        state_ids.push state.id
        current_state += 1
      end
      
      # universities
      University.populate 2 do |university|
        university.name = "University of #{Populator.words(1..2).titleize}"
        university.address1 = Faker::Address.secondary_address
        university.address2 = Faker::Address.street_address
        university.suburb = Populator.words(1).titleize
        university.state_id = state_ids # should randomly pick one
        university.postcode = 2000..9999
        university_ids.push university.id
      end
      
      # churches
      Church.populate 150 do |church|
        church.name = "#{Populator.words(1..2).titleize} Church"
        church.address1 = Faker::Address.secondary_address
        church.address2 = Faker::Address.street_address
        church.suburb = Populator.words(1).titleize
        church.state_id = state_ids # should randomly pick one
        church.postcode = 2000..9999
        church_ids.push church.id        
      end
      
      # workplaces
      Workplace.populate 300 do |workplace|
        workplace.name = Faker::Company.name
        workplace.address1 = Faker::Address.secondary_address
        workplace.address2 = Faker::Address.street_address
        workplace.suburb = Populator.words(1).titleize
        workplace.state_id = state_ids # should randomly pick one
        workplace.postcode = 2000..9999
        workplace_ids.push workplace.id        
      end
      
      # first approach: create a whole bunch of people and keep track of what basic age bracket they fall into
      # so we can use them later
      Person.populate 1000 do |person|
        person.first_name = Faker::Name.first_name
        person.middle_name = [nil, Faker::Name.first_name] # should mean some don't have middle names
        person.last_name = Faker::Name.last_name
        person.christian = [true, false]
        person.church_id = church_ids # should randomly pick one
        person.church_pastor = [nil, Faker::Name.name, "Rev. #{Faker::Name.name}"] unless !person.church_id
        person.date_of_birth = 70.years.ago.to_date..5.years.ago.to_date
        if (person.date_of_birth < 35.years.ago.to_date)
          adult_ids.push person.id
        elsif (person.date_of_birth < 18.years.ago.to_date)
          young_adult_ids.push person.id
        else
          child_ids.push person.id
        end
        person.workplace_id = workplace_ids # we might get child labourers with this, but whatever
        person.nickname = [nil, Populator.words(1.2).titleize]
        person.email = [nil, Faker::Internet.email("#{person.first_name} #{person.last_name}"), Faker::Internet.free_email("#{person.first_name} #{person.last_name}")]
        person.phone = [nil, Faker::PhoneNumber.phone_number]
        person.mobile = [nil, Faker::PhoneNumber.phone_number]
        person.address1 = Faker::Address.secondary_address
        person.address2 = Faker::Address.street_address
        person.suburb = Populator.words(1).titleize
        person.state_id = state_ids # should randomly pick one
        person.postcode = 2000..9999
      end
      
      FieldMinistry.populate 6 do |field_ministry|
        field_ministry.name = ministries[current_ministry]
        field_ministry.xml_url = "http://www.#{ministries[current_ministry].downcase.delete " "}.org/"
        
        case field_ministry.name
        when "Student Life"
          Client.populate 10 do |client|
            client.person_id = young_adult_ids
            FieldMinistryInvolvement.populate 1 do |involvement|
              involvement.field_ministry_id = field_ministry.id
              involvement.client_id = client.id
              involvement.start_date = 20.years.ago.to_date..Date.today
              involvement.end_date = involvement.start_date + ([3, 4, 5, 6].rand * [182, 365].rand)
            end
            Student.populate 1 do |student|
              student.person_id = client.person_id
              student.school_id = university_ids
            end
          end
        # TODO Other ministries here
        end
        
        current_ministry += 1
      end 
    end
  end

end