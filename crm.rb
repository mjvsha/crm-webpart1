require_relative 'contact'
require 'sinatra'


get '/' do

erb :index

end

get '/contacts' do
  @all_contacts = Contact.all
  #Model.all(options = nil) finds all the records matching the supplied options.
  #If no options are supplied, all rows from the database are returned.
  #all database rows are lso returned as an array


  erb :contacts



end

get '/about' do

  erb :about


end  






after do
  ActiveRecord::Base.connection.close
end
