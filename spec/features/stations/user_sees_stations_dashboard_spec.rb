require 'rails_helper'

describe "user visits stations dashboard" do
  before :each do
    @user = User.create(username: 'Joseph', password: '1234')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it 'see total count of stations' do
    Station.create!(name: 'Ferry Building', dock_count: 45, city: 'San Francisco', installation_date: Date.new(2017, 4, 12))
    Station.create!(name: 'Coit Tower', dock_count: 20, city: 'San Francisco', installation_date: Date.new(2017, 1, 17))

    visit stations_dashboard_path

    expect(page).to have_content("Total Station Count: #{Station.count}")
  end
  it 'see average_bikes_per_station' do
    Station.create!(name: 'Ferry Building', dock_count: 45, city: 'San Francisco', installation_date: Date.new(2017, 4, 12))
    Station.create!(name: 'Coit Tower', dock_count: 20, city: 'San Francisco', installation_date: Date.new(2017, 1, 17))

    visit stations_dashboard_path

    expect(page).to have_content("Average Bikes Per Station: #{Station.average_bikes_per_station}")
  end
  it 'see most bikes per stations' do
    station = Station.create!(name: 'Ferry Building', dock_count: 45, city: 'San Francisco', installation_date: Date.new(2017, 4, 12))
    Station.create!(name: 'Coit Tower', dock_count: 20, city: 'San Francisco', installation_date: Date.new(2017, 1, 17))

    visit stations_dashboard_path

    expect(page).to have_content("Most Bikes Per Station: #{station.dock_count}")
  end
  it 'see station with most bikes' do
    station = Station.create!(name: 'Ferry Building', dock_count: 45, city: 'San Francisco', installation_date: Date.new(2017, 4, 12))
    Station.create!(name: 'Coit Tower', dock_count: 20, city: 'San Francisco', installation_date: Date.new(2017, 1, 17))

    visit stations_dashboard_path

    expect(page).to have_content("Station With Most Bikes: #{station.name}")
  end
  it 'see least bikes per stations' do
    Station.create!(name: 'Ferry Building', dock_count: 45, city: 'San Francisco', installation_date: Date.new(2017, 4, 12))
    station = Station.create!(name: 'Coit Tower', dock_count: 20, city: 'San Francisco', installation_date: Date.new(2017, 1, 17))

    visit stations_dashboard_path

    expect(page).to have_content("Least Bikes Per Station: #{station.dock_count}")
  end

  it 'see station with least bikes' do
    Station.create!(name: 'Ferry Building', dock_count: 45, city: 'San Francisco', installation_date: Date.new(2017, 4, 12))
    station = Station.create!(name: 'Coit Tower', dock_count: 20, city: 'San Francisco', installation_date: Date.new(2017, 1, 17))

    visit stations_dashboard_path

    expect(page).to have_content("Station With Least Bikes: #{station.name}")
  end
  it 'can see most recently installed station' do
    station_1 = Station.create!(name: 'Ferry Building', dock_count: 45, city: 'San Francisco', installation_date: Date.new(2017, 4, 12))
    station_2 = Station.create!(name: 'Coit Tower', dock_count: 20, city: 'San Francisco', installation_date: Date.new(2017, 1, 17))

    visit stations_dashboard_path

    expect(page).to have_content("Newest Station: #{station_1.name}")
  end
  it 'can see oldest station' do
    station_1 = Station.create!(name: 'Ferry Building', dock_count: 45, city: 'San Francisco', installation_date: Date.new(2017, 4, 12))
    station_2 = Station.create!(name: 'Coit Tower', dock_count: 20, city: 'San Francisco', installation_date: Date.new(2017, 1, 17))

    visit stations_dashboard_path

    expect(page).to have_content("Oldest Station: #{station_2.name}")
  end




end