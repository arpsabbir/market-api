require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  include Rails.application.routes.url_helpers

  let(:order) { FactoryGirl.create :order } 
  let(:user) { order.user }
  let(:order_mailer) { OrderMailer.send_confirmation(order) }

  it "should be set to be delivered to the user from the order passed in" do
    expect(order_mailer).to deliver_to(user.email)
  end

  it "should be set to be send from no-reply@marketplace.com" do
    expect(order_mailer).to deliver_from('no-reply@marketplace.com')
  end

  it "should contain the user's message in the mail body" do
    expect(order_mailer).to have_body_text(/Order: ##{order.id}/)
  end

  it "shoud have the correct subject" do
    expect(order_mailer).to have_subject(/Order Confirmation/)
  end

  it "should have the products count" do
    expect(order_mailer).to have_body_text(/You ordered #{order.products.count} products:/)
  end
end
