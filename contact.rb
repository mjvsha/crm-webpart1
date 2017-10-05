gem 'activerecord', '=4.2.7'
require 'active_record'
require 'mini_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm.sqlite3')

class Contact < ActiveRecord::Base

  field :first_name,  as: :string
  field :last_name,   as: :string
  field :email,       as: :string
  field :note,        as: :text
  #this sets up reders and writers for each field


  def full_name
      "#{ first_name } #{ last_name }"
    end


end

Contact.auto_upgrade! 
#inheriting from activerecord will allow us to consider this class as representing one table
#creatinga new contact record will automatically insert into contacts database
