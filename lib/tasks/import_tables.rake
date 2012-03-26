namespace :db do
  desc "Import tables from a csv"
  task :import_tables => :environment do
    require 'csv'

    puts "Importing schools"
    Refinery::Schools::School.destroy_all
    CSV.foreach("csv/schools.csv", headers: true) do |row|
      school = Refinery::Schools::School.find_or_initialize_by_title(row['title'])
      %w(oldid starts_at ends_at place location price deadline extranight theme sub_theme organiser sub_organizer award intro_program publication state registrations_start_at).each do |field|
        school.send("#{field}=",row[field])
        school.save!
      end
      puts "School #{row['title']} saved."
    end

    puts "Importing events"
    puts "destroying existing events in database"
    Refinery::Events::Event.destroy_all
    CSV.foreach("csv/events.csv", headers: true) do |row|
      event = Refinery::Events::Event.new
      %w(title starts_at speaker).each do |field|
        event.send("#{field}=", row[field])
      end
      school = Refinery::Schools::School.find_by_oldid(row['school_id'])
      event.school = school
      event.save!
      puts "Event #{row['title']} for school #{school.title} saved"
    end

    puts "Importing link and categories"
    puts "destroying existing links and categories"
    Refinery::LinkCategories::LinkCategory.destroy_all
    Refinery::Links::Link.destroy_all
    CSV.foreach("csv/link_categories.csv", headers: true) do |row|
      linkcat = Refinery::LinkCategories::LinkCategory.new
      %w(oldid title).each do |field|
        linkcat.send("#{field}=", row[field])
      end
      linkcat.save!
      puts "Link Category #{row['title']} saved"
    end
    CSV.foreach("csv/links.csv", headers: true) do |row|
      link = Refinery::Links::Link.new
      %w(title url).each do |field|
        link.send("#{field}=", row[field])
      end
      if row['link_category_id']
        linkcat = Refinery::LinkCategories::LinkCategory.find_by_oldid(row['link_category_id'])
        link.link_category = linkcat
        link.save!
        puts "Link #{row['title']} for category #{linkcat.title} saved"
      else
        link.save!
        puts "Link #{row['title']} saved"
      end
    end
  end
end
