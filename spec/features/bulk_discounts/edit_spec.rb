require 'rails_helper'

RSpec.describe 'merchant bulk discount edit page', type: :feature do
  describe 'as a merchant' do
    describe 'when I visit edit_merchant_bulk_discount_path' do
      it 'has a form with the discounts current attributes pre-populated in the form' do
        expect(page).to have_selector(:css, "form")
        expect(page).to have_field(:percentage_discount, with: )
        expect(page).to have_field(:quantity_threshold, with: )
        expect(page).to have_button("Submit")
      end

      it 'when I change any/all of the information and click submit, I am redirected
      back to the bulk discounts show page and I see that the discounts attributes 
      have been updated' do

      end
    end
  end
end