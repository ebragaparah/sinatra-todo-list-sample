require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Tarefa
  include DataMapper::Resource

  property :id,           Serial
  property :title,        String, :required => true
  property :details,      String
  property :completed,    Boolean
end

DataMapper.finalize.auto_upgrade!

get '/' do
  @tarefas = Tarefa.all
  erb :index
end

post '/' do
  Tarefa.create params[:tarefa]
  redirect to('/')
end
