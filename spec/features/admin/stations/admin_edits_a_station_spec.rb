require 'rails_helper'

describe 'As an admin' do
  describe 'When I visit admin station edit' do
    before(:each) do
      @admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      @station = create(:station)
    end
    it 'allows me to edit an existing station' do
      visit edit_admin_station_path(@station)

      fill_in :station_name, with: 'Updated Station Name'
      fill_in :station_dock_count, with: 12
      fill_in :station_city, with: 'Updated City'
      fill_in :station_installation_date, with: '2018/09/13'

      click_on 'Update Station'

      expect(current_path).to eq(station_path(@station))
      expect(page).to have_content('Updated Station Name updated!')
      expect(page).to have_content('Updated Station Name')
      expect(page).to have_content('Updated City')
      expect(page).to have_content('09/13/2018')
    end
    it 'fails if all attributes are not present' do
      visit edit_admin_station_path(@station)

      fill_in :station_name, with: ''
      fill_in :station_dock_count, with: ''
      fill_in :station_city, with: ''
      fill_in :station_installation_date, with: ''

      click_on 'Update Station'

      expect(current_path).to eq(edit_admin_station_path(@station))
      expect(page).to have_content('All attributes must be present, update failed.')
    end
  end
end
