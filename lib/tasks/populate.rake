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
      child_ministry_ids = []
      
      # keep track of ids of records created so we can assign them properly later
      state_ids = []
      primary_school_ids = [] 
      high_school_ids = []
      university_ids = []
      church_ids = [nil] # should mean when randomly picked from that it can be nil
      people_ids = []
      adult_ids = []
      young_adult_ids = []
      teenager_ids = []
      child_ids = []
      workplace_ids = [nil]
      high_school_workplace_ids = []
      family_life_ids = []
      children_to_assign_to_kids_ministries = []
      married_person_ids = []
      
      
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
      
      # high schools
      HighSchool.populate 10 do |high_school|
        high_school.name = "#{Populator.words(1..2).titleize} High School"
        high_school.address1 = Faker::Address.secondary_address
        high_school.address2 = Faker::Address.street_address
        high_school.suburb = Populator.words(1).titleize
        high_school.state_id = state_ids # should randomly pick one
        high_school.postcode = 2000..9999
        high_school_ids.push high_school.id
        
        # also create it as a workplace
        Workplace.populate 1 do |workplace|
          workplace.name = high_school.name
          workplace.address1 = high_school.address1
          workplace.address2 = high_school.address2
          workplace.suburb = high_school.suburb
          workplace.state_id = high_school.state_id
          workplace.postcode = high_school.postcode
          high_school_workplace_ids.push workplace.id        
        end        
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
        person.date_of_birth = 85.years.ago.to_date..5.years.ago.to_date
        person.workplace_id = workplace_ids # assume everyone has a job to start with - will nil out children's jobs
        if (person.date_of_birth < 35.years.ago.to_date)
          # give a third of adults a spouse as well
          if [1,2,3].rand == 1 and !adult_ids.empty?
            person.spouse_id = adult_ids - married_person_ids 
            # keep track of who we set as married so we can set the reciprocal relationship later
            married_person_ids.push person.id
          end
          adult_ids.push person.id
        elsif (person.date_of_birth < 18.years.ago.to_date)
          young_adult_ids.push person.id
        elsif (person.date_of_birth < 12.years.ago.to_date)
          teenager_ids.push person.id
        else
          person.workplace_id = nil
          child_ids.push person.id
        end
        person.nickname = [nil, Populator.words(1.2).titleize]
        person.email = [nil, Faker::Internet.email("#{person.first_name} #{person.last_name}"), Faker::Internet.free_email("#{person.first_name} #{person.last_name}")]
        person.phone = [nil, Faker::PhoneNumber.phone_number]
        person.mobile = [nil, Faker::PhoneNumber.phone_number]
        person.address1 = Faker::Address.secondary_address
        person.address2 = Faker::Address.street_address
        person.suburb = Populator.words(1).titleize
        person.state_id = state_ids # should randomly pick one
        person.postcode = 2000..9999
        # for 1 in 5 people, create up to a few life events, so long as they are over 18
        if [1,2,3,4,5].rand == 5 and person.date_of_birth < 18.years.ago.to_date
          LifeEvent.populate 1..2 do |life_event|
            life_event.person_id = person.id
            life_event.description = ["Marriage", "Instrument Purchase", "Solo Album Release"] # all I could think of
            life_event.event_date = 18.years.ago.to_date..3.years.from_now.to_date
          end
        end
      end
      
      # set the reciprocal marriage relationships
      married_person_ids.each do |married_person_id|
        spouse = Person.find(married_person_id).spouse
        spouse.spouse_id = married_person_id
        spouse.save
      end
      
      FieldMinistry.populate 6 do |field_ministry|
        field_ministry.name = ministries[current_ministry]
        field_ministry.xml_url = "http://www.#{ministries[current_ministry].downcase.delete " "}.org/"
        
        case field_ministry.name
        when "Student Life"
          Client.populate 10 do |client|
            client.person_id = young_adult_ids
            current_person = Person.find(client.person_id)
            FieldMinistryInvolvement.populate 1 do |involvement|
              involvement.field_ministry_id = field_ministry.id
              involvement.client_id = client.id
              involvement.start_date = (current_person.age - 18).years.ago.to_date..Date.today
              involvement.end_date = involvement.start_date + ([3, 4, 5, 6].rand * [182, 365].rand)
              involvement.became_christian = [true, false]
              Student.populate 1 do |student|
                student.person_id = client.person_id
                student.school_id = university_ids
                student.start_date = involvement.start_date..involvement.end_date
                student.end_date = student.start_date..involvement.end_date
              end
            end
            # TODO Should probably add degrees here as well
          end
        when "Athletes In Action"
          Client.populate 10 do |client|
            client.person_id = young_adult_ids + adult_ids
            FieldMinistryInvolvement.populate 1 do |involvement|
              involvement.field_ministry_id = field_ministry.id
              involvement.client_id = client.id
              involvement.start_date = (18.years.ago.to_date)..Date.today
              involvement.end_date = [nil, involvement.start_date + ((1..10).to_a.rand * [30, 90, 182, 365].rand)]
              involvement.became_christian = [true, false]
            end
            # TODO Should probably give them a special basketball workplace, maybe
          end          
        when "Family Life"
          # the parents
          Client.populate 10 do |client|
            client.person_id = adult_ids
            FieldMinistryInvolvement.populate 1 do |involvement|
              involvement.field_ministry_id = field_ministry.id
              involvement.client_id = client.id
              involvement.start_date = 30.years.ago.to_date..Date.today
              involvement.end_date = [nil, involvement.start_date + ((1..10).to_a.rand * [30, 90, 182, 365].rand)]
              involvement.became_christian = [true, false]
            end
            family_life_ids.push client.person_id # keep a list of the parent's person_ids
          end      
          # create some children
          # might not want all 5 to be clients
          Client.populate 5 do |client|
            client.person_id = child_ids
            Person.update(client.person_id, :parent_id => family_life_ids.rand) # set their parent to be a random Family Life person
            # for about half the kids, add them to a list for later adding to a kids ministry
            if [1,2].rand == 2
              children_to_assign_to_kids_ministries.push client.id
            end
          end          
        when "Children of the World"
          Client.populate 10 do |client|
            client.person_id = child_ids
            # have around half of them as kids of one of the Family Life clients
            if [1,2].rand == 2
              Person.update(client.person_id, :parent_id => family_life_ids.rand)
            end
            FieldMinistryInvolvement.populate 1 do |involvement|
              involvement.field_ministry_id = field_ministry.id
              involvement.client_id = client.id
              involvement.start_date = 10.years.ago.to_date..Date.today
              involvement.end_date = [nil, involvement.start_date + ((1..10).to_a.rand * [30, 90, 182, 365].rand)]
              involvement.became_christian = [true, false]
            end
          end
          child_ministry_ids.push field_ministry.id
        when "Youth Ministry"
          Client.populate 10 do |client|
            client.person_id = child_ids
            # have around half of them as kids of one of the Family Life clients
            if [1,2].rand == 2
              Person.update(client.person_id, :parent_id => family_life_ids.rand)
            end
            FieldMinistryInvolvement.populate 1 do |involvement|
              involvement.field_ministry_id = field_ministry.id
              involvement.client_id = client.id
              involvement.start_date = 10.years.ago.to_date..Date.today
              involvement.end_date = [nil, involvement.start_date + ((1..10).to_a.rand * [30, 90, 182, 365].rand)]
              involvement.became_christian = [true, false]
            end
          end
          child_ministry_ids.push field_ministry.id
        when "CRAM"
          # 8 high school students
          Client.populate 8 do |client|
            client.person_id = teenager_ids
            current_person = Person.find(client.person_id)
            Student.populate 1 do |student|
              student.person_id = client.person_id
              student.school_id = high_school_ids # random high school
              student.start_date = current_person.date_of_birth + (12..current_person.age).to_a.rand * 365
              student.end_date = nil # all are currently at school
            end
            FieldMinistryInvolvement.populate 1 do |involvement|
              involvement.field_ministry_id = field_ministry.id
              involvement.client_id = client.id
              involvement.start_date = 10.years.ago.to_date..Date.today
              involvement.end_date = [nil, involvement.start_date + ((1..10).to_a.rand * [30, 90, 182, 365].rand)]
              involvement.became_christian = [true, false]
            end
          end
          # 2 high school teachers
          Client.populate 2 do |client|
            client.person_id = young_adult_ids + adult_ids
            Person.update(client.person_id, :workplace_id => high_school_workplace_ids.rand) # set them to work in a random high school work place
            FieldMinistryInvolvement.populate 1 do |involvement|
              involvement.field_ministry_id = field_ministry.id
              involvement.client_id = client.id
              involvement.start_date = 10.years.ago.to_date..Date.today
              involvement.end_date = [nil, involvement.start_date + ((1..10).to_a.rand * [30, 90, 182, 365].rand)]
              involvement.became_christian = [true, false]
            end
          end  
        end
        
        current_ministry += 1
      end 
      
      # now we know the correct ids for kids ministries (it might vary, best to be safe)
      # we can assign those kids from earlier to a random one
      children_to_assign_to_kids_ministries.each do |client_id|      
        FieldMinistryInvolvement.populate 1 do |involvement|
          involvement.field_ministry_id = child_ministry_ids # random kids ministry
          involvement.client_id = client_id # the current kid's client_id
          involvement.start_date = 10.years.ago.to_date..Date.today
          involvement.end_date = [nil, involvement.start_date + ((1..10).to_a.rand * [30, 90, 182, 365].rand)]
          involvement.became_christian = [true, false]
        end
      end

      
    end
  end

end