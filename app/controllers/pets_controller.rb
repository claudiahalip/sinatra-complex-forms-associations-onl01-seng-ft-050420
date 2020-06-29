class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'pets/new'
  end

   post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      owner = Owner.create(params[:owner])
      owner.pets << @pet
    end
    redirect to "/pets/#{@pet.id}"
  end
  

  get '/pets/:id' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'pets/show'
  end
  
  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find_by_id(params[:id])
    erb :'pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find_by(params[:id])
    @pet.update(params[:pet])
    
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params[:owner][:name])
      owner.pets << @pet
    end
    redirect to "/pets/#{@pet.id}"
  end
end