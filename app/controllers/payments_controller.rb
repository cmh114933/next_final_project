class PaymentsController < ApplicationController

  def create
    pricing = PricingPlan.find(params[:payment][:pricing_plan_id])
    nonce = params[:payment_method_nonce]
    render 'pricing_plans/show' and return unless nonce
    result = Braintree::Transaction.sale(
      amount: "#{pricing.price_of_coin}",
      payment_method_nonce: params[:payment_method_nonce]
    )
    if result.success?
      #make an email send to owner and reservation owner
      flash[:message] = "Payment success! Would u like to buy another package?"
      redirect_to pricing_plans_path
    else
      flash[:message] = 'Failed. Please try again'
      redirect_to pricing_plans_path
    end
    # reserve to save the transaction details into database
  end

end
