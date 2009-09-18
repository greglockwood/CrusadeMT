namespace :db do
  namespace :populate do
    desc "Erase and fill default values for Australian states"
    task :states => :environment do
      States.delete_all
      [["Australian Capitol Territory", "ACT"], 
      ["New South Wales", "NSW"], 
      ["Northern Territory", "NT"], 
      ["South Australia","SA"], 
      ["Tasmania","TAS"], 
      ["Victoria","VIC"],
      ["Western Australia","WA"]].each do |name,abbrev|
        States.create({:name => name, :abbreviation => abbrev})
      end
    end
  end

end