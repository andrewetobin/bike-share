require 'rails_helper'

describe 'Admin Condition Index Page' do
  describe 'as an admin when I visit the condition index page' do
    before(:each) do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      @condition1 = create(:condition)
      @condition2 = create(:condition)
    end
    it 'should show me all conditions with a link to edit or delete a condition' do
      visit conditions_path

      expect(page).to have_content("#{@condition1.date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{@condition1.max_temperature}")
      expect(page).to have_content("#{@condition1.mean_temperature}")
      expect(page).to have_content("#{@condition1.min_temperature}")
      expect(page).to have_content("#{@condition1.mean_humidity}")
      expect(page).to have_content("#{@condition1.mean_visibility}")
      expect(page).to have_content("#{@condition1.mean_wind_speed}")
      expect(page).to have_content("#{@condition1.precipitation}")

      expect(page).to have_content("#{@condition2.date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{@condition2.max_temperature}")
      expect(page).to have_content("#{@condition2.mean_temperature}")
      expect(page).to have_content("#{@condition2.min_temperature}")
      expect(page).to have_content("#{@condition2.mean_humidity}")
      expect(page).to have_content("#{@condition2.mean_visibility}")
      expect(page).to have_content("#{@condition2.mean_wind_speed}")
      expect(page).to have_content("#{@condition2.precipitation}")

      expect(page).to have_button("Edit")
      expect(page).to have_button("Delete")
    end
    it 'allows an admin to create a new condition' do
      visit new_admin_condition_path

      fill_in :condition_date, with: '2018/09/13'
      fill_in :condition_max_temperature, with: 80
      fill_in :condition_mean_temperature, with: 60
      fill_in :condition_min_temperature, with: 50
      fill_in :condition_mean_humidity, with: 34.0
      fill_in :condition_mean_visibility, with: 10
      fill_in :condition_mean_wind_speed, with: 4
      fill_in :condition_precipitation, with: 0.05

      click_on "Create Condition"

      expect(current_path).to eq(condition_path(Condition.last))
      expect(page).to have_content("09/13/2018")
      expect(page).to have_content("80")
      expect(page).to have_content("60")
      expect(page).to have_content("50")
      expect(page).to have_content("34")
      expect(page).to have_content("10")
      expect(page).to have_content("4")
      expect(page).to have_content("0.05")
    end
    it 'requires all attributes to be present to create a condition' do
      visit new_admin_condition_path

      fill_in :condition_date, with: '09/13/2018'
      fill_in :condition_max_temperature, with: ''
      fill_in :condition_mean_temperature, with: ''
      fill_in :condition_min_temperature, with: 50
      fill_in :condition_mean_humidity, with: 34.0
      fill_in :condition_mean_visibility, with: ''
      fill_in :condition_mean_wind_speed, with: 4
      fill_in :condition_precipitation, with: 0.05

      click_on "Create Condition"

      expect(current_path).to eq(new_admin_condition_path)
      expect(page).to have_content('Condition was not created.')
    end
    it 'allows me to delete a condition' do
      admin = create(:user, role: 1)
      condition1 = create(:condition)
      condition2 = create(:condition)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit conditions_path

      within("#condition-#{@condition1.id}") do
        click_button 'Delete'
      end

      expect(current_path).to eq(conditions_path)

      expect(page).to have_content('Condition deleted.')

      expect(page).to_not have_content(@condition1.max_temperature)
      expect(page).to_not have_content(@condition1.mean_temperature)
      expect(page).to_not have_content(@condition1.min_temperature)
      expect(page).to_not have_content(@condition1.mean_humidity)
      expect(page).to_not have_content(@condition1.mean_visibility)
      expect(page).to_not have_content(@condition1.mean_wind_speed)
    end
  end
end
