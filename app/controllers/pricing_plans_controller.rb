class PricingPlansController < ApplicationController

	def show
		@user = User.find(current_user.id)
	    @client_token = Braintree::ClientToken.generate
	    @pricing = PricingPlan.find(params[:id])
	    @payment = Payment.new
	end

	def index
		@price = PricingPlan.all		
	end

private
	def pricing_params
		params.require(:pricing_plan).permit(:price_of_coin, :value_of_coin)	
	end
end