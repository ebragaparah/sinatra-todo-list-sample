require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Tarefa
  include DataMapper::Resource

  property :id,           Serial
  property :content,      String, :required => true
  property :completed_at, DateTime
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

get '/tarefas/:id' do |id|
  @tarefa = Tarefa.get!(id)
  erb :'tarefas/show'
end
