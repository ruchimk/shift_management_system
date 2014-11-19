module WelcomeHelper
  def time_options
    am_options = []
    increment = 0
    (1..11).each do |i|
      am_options << ["#{i}:00am", 60 + increment]
      am_options << ["#{i}:30am", 90 + increment]
      increment += 60
    end
    am_options = [["12:00am", 0] ,["12:30am", 30]] + am_options
    pm_options = []
    increment_pm = 720
    (1..11).each do |i|
      pm_options << ["#{i}:00pm", 60 + increment_pm]
      pm_options << ["#{i}:30pm", 90 + increment_pm ]
      increment_pm += 60
    end
    pm_options = [["12:00pm",720],["12:30pm",750]] + pm_options
    am_options + pm_options 
  end
end

