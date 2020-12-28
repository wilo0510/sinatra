require "sinatra"

def workshop_content(file)
    File.read("texto/#{file}.txt")
rescue Errno::ENOENT
    return nil
end 
def save_content(name,description)
    File.open("texto/#{name}.txt","w") do |file|
        file.print(description)
    end
end

get '/' do
    @files = Dir.entries("texto")    
    erb :home
end

get '/create' do
    erb:form
end

get '/:nombre' do
    @nombre= params[:nombre]
    @description= workshop_content(@nombre)
    erb:taller
end
post '/create' do    
    save_content(params["name"],params["description"])
end

