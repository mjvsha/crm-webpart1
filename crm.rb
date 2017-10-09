require_relative 'contact'
require 'sinatra'


get '/' do

erb :index

end

get '/about' do

  erb :about


end

get '/contacts' do
  @all_contacts = Contact.all
  #Model.all(options = nil) finds all the records matching the supplied options.
  #If no options are supplied, all rows from the database are returned.
  #all database rows are lso returned as an array


  erb :contacts



end


get '/contacts/new' do

#this only works if i put it before the one below this
  erb :new
end



get '/contacts/:id' do
  #params[:id] params is a hash. id is the key and we retrieve the value from it

  @contact = Contact.find_by({id: params[:id].to_i})
  #this is gonna fetch the contact witht he matching id

  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end



end



post '/contacts' do
  Contact.create(
    first_name:   params[:first_name],
    last_name:    params[:last_name],
    email:        params[:email],
    note:         params[:note],

  )

  redirect to ('/contacts')
end

get '/contacts/:id/edit' do

  @contact = Contact.find_by(id: params[:id].to_i)

  if @contact
    erb :edit_contact
  else
    raise Sinatra: :NotFound

  end

end

put '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
    if @contact
      @contact.update(
      first_name:   params[:first_name],
      last_name:    params[:last_name],
      email:        params[:email],
      note:         params[:note]
      )
    redirect to('/contacts')

  else
    raise Sinatra::NotFound
  end
end

delete '/contacts/:id' do
  @contact= Contact.find(params[:id].to_i)
    if @contact
    @contact.delete
    redirect to('/contacts')
    else
    raise Sinatra::NotFound
  end 

end



after do
  ActiveRecord::Base.connection.close
end


#crm part 3
# we want the userts to see indiivudal contact dtails on their own page
# to do this we establish a dynamic route, whch has the user id in it
#
#
# to tell sinatra what would happen if we enter diffeent id urls
# u need to do :id after slash
#
# therefore, creae a new view called show_contacts.erb so that this is where its gonna redirect
