class Authentication::SessionsController < Devise::SessionsController
  def new
    super do |user|
      puts "I'm invoked!"
    end
  end
end
