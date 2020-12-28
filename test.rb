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
def delete_element(name)
    File.delete("texto/#{name}.txt")
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
get "/:name/edit" do
    @name=params[:name]
    @description=workshop_content(@name)
    erb:edit
end
post '/create' do
    @message="creado"    
    save_content(params["name"],params["description"])
    erb:message
end

delete '/:name' do
    @message="eliminado"
    delete_element(params[:name])
    erb:message
end

put '/:name' do    
    save_content(params[:name],params["description"])
    redirect URI.escape("/#{params[:name]}")
end

