require 'rails_helper'

RSpec.describe 'merchant bulk discount edit page', type: :feature do
  describe 'as a merchant' do
    describe 'when I visit edit_merchant_bulk_discount_path' do
      before :each do
        @merchant1 = Merchant.create!(name: 'Hair Care')
    
        @bulk_discount_a = BulkDiscount.create!(merchant_id: @merchant1.id, percentage_discount: 20, quantity_threshold: 10)
        @bulk_discount_b = BulkDiscount.create!(merchant_id: @merchant1.id, percentage_discount: 15, quantity_threshold: 5)
        @bulk_discount_c = BulkDiscount.create!(merchant_id: @merchant1.id, percentage_discount: 30, quantity_threshold: 20)
    
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
        @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
        @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
        @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
        @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')
    
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
        @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
        @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
        @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
        @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
        @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
        @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)
    
        @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
        @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
        @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
        @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
    
        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
        @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
        @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
        @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
        @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
        @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
        @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    
        @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
        @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
        @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
        @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
        @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
        @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
        @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)
    
        visit edit_merchant_bulk_discount_path(@merchant1, @bulk_discount_a)
      end

      it 'has a form with the discounts current attributes pre-populated in the form' do
        expect(page).to have_selector(:css, "form")
        expect(page).to have_field(:percentage_discount, with: 20)
        expect(page).to have_field(:quantity_threshold, with: 10)
        expect(page).to have_button("Submit")
      end

      it 'when I change any/all of the information and click submit, I am redirected
      back to the bulk discounts show page and I see that the discounts attributes 
      have been updated' do
        fill_in :percentage_discount, with: 25
        fill_in :quantity_threshold, with: 15
        click_button "Submit"

        expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bulk_discount_a))

        expect(page).to have_content("Percentage Discount: 25%")
        expect(page).to have_content("Quantity Threshold: 15")
      end
    end
  end
end