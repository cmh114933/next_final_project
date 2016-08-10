class PricingPlansController < ApplicationController

	def show
		@user = User.find(current_user.id)
	    @client_token = Braintree::ClientToken.generate
	    @pricing = PricingPlan.find(params[:id])
	    @payment = Payment.new
	end

	def index
		@price = PricingPlan.all
		@p1 = @price.find(1)
		@p2 = @price.find(2)
		@p3 = @price.find(3)
		@p4 = @price.find(4)
		@p5 = @price.find(5)
	end

private
	def pricing_params
		params.require(:pricing_plan).permit(:price_of_coin, :value_of_coin)	
	end
end