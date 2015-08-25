
require('pg')
require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
require('./lib/survey')
require('./lib/question')
also_reload('lib/**/*.rb')
require 'pry'
require 'thin'


##########################
####___Index-Entry___#####
##########################
get("/") do
	erb(:index)
end


##########################
####___Surveys-Entry___###
##########################
get("/surveys") do
	@surveys = Survey.all()
	erb(:surveys)
  # redirect '/'
end


##########################
#####___Survey-Form___####
##########################
get("/surveys/new") do
	erb(:survey_form)
end

post("/surveys") do
	name = params.fetch("name")
	survey = Survey.new({:name => name})
	survey.save()
  @surveys = Survey.all()
	erb(:surveys)
end


##########################
######___Clear-All___#####
##########################
get("/clear") do
	Survey.delete_all()
  @surveys = Survey.all()
	erb(:index)
end


##########################
####___Survey-Entry___####
##########################
get("/surveys/:survey_id") do
	@survey = Survey.find(params.fetch("survey_id").to_i())
	erb(:survey)
end

delete '/surveys/:survey_id/delete' do
	@survey = Survey.find(params['survey_id'].to_i)
	@survey.destroy
	@surveys = Survey.all()
	erb(:surveys)
end

patch '/surveys/:survey_id' do
	@survey = Survey.find(params['survey_id'].to_i)
	@survey.update({name: params['name']})
	@surveys = Survey.all()
	erb(:surveys)
end



##########################
####___Question-Form___###
##########################
get("/surveys/:survey_id/new") do
	@survey = params.fetch("survey_id").to_i()
	erb(:question_form)
end

post("/surveys/:survey_id/questions") do
	name = params.fetch("name")
	@survey_id = params.fetch("survey_id").to_i()
	@survey = Survey.find(@survey_id)
	@question = Question.new({:name => name, :survey_id => @survey_id})
	@question.save()
	erb(:survey)
end


##########################
####___Question-Entry___##
##########################
get("/surveys/:survey_id/questions/:id") do
	@survey = Survey.find(params.fetch("survey_id").to_i())
	@question = Question.find(params.fetch("id").to_i())
	erb(:employee)
end

delete '/surveys/:survey_id/questions/:id' do
	@survey = Survey.find(params.fetch("survey_id").to_i())
	@question = Question.find(params['id'].to_i)
	@question.destroy
	@questions = Question.all()
	redirect "/surveys/#{@survey.id()}"
end

patch '/surveys/:survey_id/questions/:id' do
	@survey = Survey.find(params.fetch("survey_id").to_i())
	@question = Question.find(params['id'].to_i)
	@question.update({name: params['name']})
	@questions = Question.all()
	redirect "/surveys/#{@survey.id()}"
end
