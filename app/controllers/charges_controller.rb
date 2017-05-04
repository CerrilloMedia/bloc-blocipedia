class ChargesController < ApplicationController
  
  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "BigMoney Membership - #{current_user.email}",
      amount: Amount.default
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create( 
      customer: customer.id,
      amount: Amount.default,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )
    
    if charge
      current_user.premium!
    end
    
    flash[:notice] = "Thanks for all the money #{current_user.email}! Feel free to pay me again."
    redirect_to root_path
    
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
    
  end
  
  def destroy
    
    current_user.standard!
    
    if current_user.standard?
      flash[:notice] = "Membership status downgraded to STANDARD. \n All private posts have been changed to PUBLIC."
    else
      flash[:alert] = "There was an error with your request. Please try again."
    end
    
    current_user.downgrade_wikis
    
    redirect_to edit_user_registration_path
    
  end
  
end