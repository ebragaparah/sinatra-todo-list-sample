require 'sinatra'

get '/' do
  erb :index
end

get '/:tarefa' do
  @tarefa = params[:tarefa].gsub!('-', ' ').capitalize
  erb :tarefa
end
