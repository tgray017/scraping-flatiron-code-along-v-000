require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
    def print_courses
      self.make_courses
      Course.all.each do |course|
        if course.title
          puts "Title: #{course.title}"
          puts "  Schedule: #{course.schedule}"
          puts "  Description: #{course.description}"
        end
      end
    end
    
    def get_page
      Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses'))
    end
    
    def get_courses
      binding.pry
      get_page.css('#course-grid .posts-holder')
    end
    
    def make_courses
      courses = doc.css('article')
      get_courses.each do |courses_array|
        courses_array.each do |course_object| 
          binding.pry
          course = Course.new
          course.title = course_object.css('h2').text
          course.schedule = course_object.css('em').text
          course.description = course_object.css('p').text
          #binding.pry
        end
      end
    end
  
end

scraper = Scraper.new
scraper.print_courses


