# Taken from the cucumber-rails project.

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /the organization sign up page/
      '/signup_organization'

    when /the member sign up page/
      '/signup_member'

    when /the welcome page/
      '/welcome'
    
    when /the login page/
      '/sign_in'

    when /the products page/
      '/products'

    when /the profile page/
      '/profile'

    when /the marketplace page/
      '/marketplace'

    when /the tag marketplace page/
      '/tag_marketplace'

    when /the member profile page/
      '/members/1'
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))
  
      else
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
  end
end

World(NavigationHelpers)