class GamesController < ApplicationController

	def show
	skip_before_action :verify_authenticity_token

	def create


		if Game.where(status: "PENDING").empty?
			@game=Game.create(status: "PENDING")
		else
			@game=Game.find_by_status("PENDING")
		end		
		@player = Player.create(user_id: current_user.id, game_id: @game.id)
		@game.update(status:"READY")if Player.where(game_id:@game.id).count == 3
		render json: { status: @game.status, game_id:@game.id}
	end

	def show
		@game = Game.find(params[:id])
		all_players=@game.players
		@game.update(current_player_id:all_players[rand(all_players.length)].id) if @game.current_player_id.nil?
		d_arr= [3,2,6,5,2,3,4,3,1,2,4,3,5,6,3,2,6,2,3,4,3,2,1,3,5,5,5,6,5,6,4,2,5]
		ev_arr = [
			[4,"news_ev","NE1","Titanic Co. announces  launch of cutting edge technology equipped mega ship, The Titanic"],
			[3,"occu_ev","OE1", "Job offer at Monsanto Corp"],
			[7,"news_ev","NE2","Discovery of shale oil, a potential substitute for oil and petrol."],
			[9,"occu_ev","OE2","Job offer at Umbrella Corp"],
			[5,"m_news_ev","MNE1", "Pirate activity increasingly prevalent in Somalia waters"],
			[10,"m_news_ev","MNE2", "Unknown illness arising in certain areas close to pharmaceutical companies"],
			[13, "stock_ev","SE1","Stock purchase offer for Mc Donald Stocks"],
			[8, "m_news_ev","MNE3","Digger Co. has discovered a new gold mine in Africa, seeks to negotiate contract with government, announce of engaging services of Titanic Co."],
			[11, "news_ev","","Take a coffee break"],
			[15, "m_news_ev","MNE4","Bob's Builders engaged in construction of new research facilities"],
			[12, "m_news_ev","MNE5","Mc Donald's Salad discovered to utilize Monsanto produce"],
			[14, "news_ev","NE3","Bob Construction building for Digger Co breaks down due to cutting corners, resulting in loss of life"],
			[20,"m_news_ev stock_ev","MNE6 SE2","Steve Jobs gives talks on release of the new Iphone New Gen. Special stock purchase offer of Apple shares"],
			[18, "m_news_ev","MNE7","Samsung engages Digger Co for import of raw materials for building next gen computer chips, to be delivered using the Titanic"],
			[17, "m_news_ev","MNE7","Reports of Samsung phone overheating"],
			[2,"m_news_ev","MNE5","Mysterious deaths of chickens. Unknown causes, but relatively contained in scope"],
			[4,"global_ev","GE1","Pirate are becoming more rampant. As a concerned citizen, do you think the government should take action?"],
			[19,"m_news_ev","MNE6","Steve Jobs dies"],
			[5,"m_news_ev","MNE1 MNE3 MNE7","Titanic due to cross through Somalia waters"],
			[8,"m_news_ev","MNE1 MNE3 MNE7","Digger Co. suffers huge losses as latest shipment on Titanic raided by pirates. African insurgence has occured, resulting in further losses"],
			[2,"m_news_ev","MNE5","Confirmed new viral infection of fowl, chickens dying everywhere"],
			[7,"m_news_ev","MNE3","Military coup occurs in Africa, new regime attacks Digger Co Mines"],
			[9,"m_news_ev","MNE2","New cure all drug announced by Umbrella Corp, capable of rejuvenating skin and combating old age, making you seem ALIVE again. Code name : T"],
			[5,"m_news_ev","MNE1 MNE3 MNE7","Titanic Sunk"],
			[12,"m_news_ev","MNE5","Global outrage at Monsanto Chemical irradiated produce, chicken virus discovered to be due to genetic mutation from Monsanto chicken feed. Mc Donald's uses a lot of Monsanto product and chickens"],
			[14,"news_ev","NE4","Bob's Builders successful construction of the Tallest Building in the World"],
			[10, "m_news_ev","MNE2","Umbrella revealed to be conducting human experiments"],
			[18, "m_news_ev","MNE7","Samsung phone Z series exploding, harming hundreds"],
			[19, "m_news_ev","MNE6","Google announces newest product: Th Google Phone, with all the capabilities of the Iphone New Gen, only cheaper and better"],
			[16,"exchange_ev","","Money Exchange"],
			[2,"global_ev","GE2","Monsanto goes bankrupt"],
			[1,"evaluation_ev","","Special evaluation"],
			[1,"evaluation_ev","","Special evaluation"]
		]
		stock_arr=[
			['Agri',1,80000,"Agriculture"],
			['Ship',2,70000,"Shipping"],
			['Mine',3,60000,"Mining"],
			['Pharma',4,50000,"Pharmaceutical"],
			['FnB',5,40000,"Food & Beverages"],
			['Construct',6,30000, "Construction"],
			['Electro',7,20000, "Electronics"],
			['Computer',8,10000, "Computing"],
			['Apple',9,90000, "Computing"],
			['Mc Donalds',10,99999,"Food & Beverages"]
		]
		if Dice.all.empty?
			d_arr.each do |x|
				Dice.create(roll:x)
			end
		end
		if BoardSpace.all.empty?
			20.times{|x|BoardSpace.create(position:x+1)}
		end
		if Message.all.empty?
			temp_events = []
			ev_arr.each do |x|
				
			
				x[2].split(" ").each do |e|
					temp_events << Array(e) if e != ""
				end
				temp_events.uniq!


				BoardSpace.find_by(position:x[0]).messages.create(event:x[3],event_type:x[1],series:x[2])
			end
				temp_events.each do |a|
					a << 0
				end
				@game.events = temp_events
				@game.save
		end
		if Stock.all.empty?
			stock_arr.each do |x|
				@game.stocks.create(company_name:x[0],price:x[1],quantity:x[2],s_type:x[3])
			end
		end
		if OwnedStock.all.empty?
			Player.all.each do |p|
				Stock.all.each do |s|
					p.owned_stocks.create(company_name:s.company_name,price:s.price,quantity:0,s_type:s.s_type)
				end
			end
		end
		Message.all.each do |x|
			x.update(times_called:0)
		end
		gon.publish_key = ENV['PUBNUB_PUBLISH_KEY']
		gon.subscribe_key = ENV['PUBNUB_SUBSCRIBE_KEY']
		gon.user_email = current_user.email
		gon.game_id=@game.id
	end

	def dice

		game_id = request.referrer.split("/").last
		@game = Game.find(game_id)
		@game.update(number_of_turns: @game.number_of_turns + 1)
		current_player= Player.find(@game.current_player_id)

		d_roll=Dice.find(@game.number_of_turns).roll
		new_position = current_player.position+d_roll
		new_position = new_position - 20 if new_position > 20

		current_player.update(position:new_position)


		render json:  {position: current_player.position}
	end	

	def player_turn
		game_id = request.referrer.split("/").last
		@game= Game.find(game_id)
		my_player= Player.where(user_id:current_user.id,game_id:game_id).last

		if @game.current_player_id == my_player.id
			player_turn = "YOUR TURN"
		else 
			player_turn = Player.find(@game.current_player_id).user.email + "'s TURN"
		end

		render json: {player_turn: player_turn} 
	end

	def event_check
		game_id = request.referrer.split("/").last
		@game= Game.find(game_id)
		current_player= Player.find(@game.current_player_id)	

		temp_prompt= BoardSpace.find_by(position:current_player.position).messages
		if temp_prompt[0].times_called == 0
			prompt = temp_prompt[0]
		elsif temp_prompt[1].times_called == 0
			prompt = temp_prompt[1]
		else
			prompt = temp_prompt[2]
		end
		prompt.update(times_called:prompt.times_called+1)
		total_times_called = 0
		Message.all.each do |x|
			total_times_called = total_times_called + x.times_called
		end

		if total_times_called >= 33
			Message.all.each do |x|
				x.update(times_called:0)
			end
		end
		if @game.current_player_id == @game.players.last.id
			id_update = @game.players.first.id
		else
			id_update = @game.current_player_id + 1
		end
		@game.update(current_player_id:id_update)
		render json: {event: prompt.event,e_type: prompt.event_type,e_series:prompt.series}

	end

	def player_position
		game_id = request.referrer.split("/").last
		@game= Game.find(game_id)
		current_player= Player.find(@game.current_player_id)
		my_player= Player.where(user_id:current_user.id,game_id:game_id).last
		render json: {position:current_player.position,my_player_position:my_player.position,player:current_player.user.email, player_id:current_player.id}
	end

	def buy_stocks

		game_id = request.referrer.split("/").last
		@game= Game.find(game_id)
		current_player= Player.find(@game.current_player_id)
		stock_b = Stock.find(params[:s_id].to_i)	
		my_stock = OwnedStock.find_by(company_name:stock_b.company_name)
		my_stock.update(quantity:params[:quantity].to_i) 
		stock_b.update(quantity:stock_b.quantity-params[:quantity].to_i)
		render json: {s_quantity:stock_b.quantity,s_id:stock_b.id}
	end

	def sell_stocks
		game_id = request.referrer.split("/").last
		@game= Game.find(game_id)
		current_player= Player.find(@game.current_player_id)
		stock_b = Stock.find(params[:s_id].to_i)	
		my_stock = OwnedStock.find_by(company_name:stock_b.company_name)
		my_stock.update(quantity:my_stock.quantity-params[:quantity].to_i) 
		stock_b.update(quantity:stock_b.quantity+params[:quantity].to_i)
		render json: {s_quantity:stock_b.quantity,s_id:stock_b.id}
	end

	def event_trigger
		game_id = request.referrer.split("/").last
		@game= Game.find(game_id)
		new_events = []
		@game.events.each do |x|
			params[:series].split(" ").each do |e|
				res= x
				res[1]=(res[1].to_i+1).to_s if x[0] == e
				new_events << res			
			end
		end

		@game.update(events:new_events)
		render json: {id:@game.id}
	end

	def stock_price_change
		game_id = request.referrer.split("/").last
		@game= Game.find(game_id)
		current_player= Player.find(@game.current_player_id)
		@game.events.each do |x|
			if x[0] == 'NE1'
				if x[1] == 1
					st_mkt= @game.stocks.find_by(company_name:'Ship')
					my_st =current_player.owned_stocks.find_by(company_name:'Ship')
					percentage=130%
				end
			# elsif x[0] == 'OE1'
			elsif x[0] == 'NE2'
				if x[1] == 1
					st_mkt= @game.stocks.find_by(company_name:'Mine')
					my_st =current_player.owned_stocks.find_by(company_name:'Mine')
					percentage=200%
				end				
			# elsif x[0] == 'OE2'
			elsif x[0] == 'MNE1'
				if x[1] >= 1
				end				
			elsif x[0] == 'MNE2'
				if x[1] >= 1
				end			
			# elsif x[0] == 'SE1'
			elsif x[0] == 'MNE3'
				if x[1] >= 1
				end			
			elsif x[0] == 'MNE4'
				if x[1] >= 1
				end			
			elsif x[0] == 'MNE5'
				if x[1] >= 1
				end			
			elsif x[0] == 'NE3'
				if x[1] == 1
					st_mkt= @game.stocks.find_by(company_name:'Construct')
					my_st =current_player.owned_stocks.find_by(company_name:'Construct')
					percentage=60%
				end
			elsif x[0] == 'MNE6'
				if x[1] >= 1
				end			
			# elsif x[0] == 'SE2'
			elsif x[0] == 'MNE7'
				if x[1] >= 1
				end			
			elsif x[0] == 'GE1'
				if x[1] >= 2

				end			
			elsif x[0] == 'NE4'
				if x[1] == 1
					st_mkt= @game.stocks.find_by(company_name:'Construct')
					my_st =current_player.owned_stocks.find_by(company_name:'Construct')
					percentage=200%
				end
			elsif x[0] == 'GE2'
				if x[1] == 1
				end
		end
		st_mkt.update(price:st_mkt*percentage)
		my_st.update(price:my_st*percentage)

	end
end


# 100.times{Dice.create(roll:rand(1..6))}
# 20.times{|x|BoardSpace.create(position:x+1)}
# [["NE1", "1"], ["OE1", "1"], ["NE2", "1"], ["OE2", "0"], ["MNE1", "0"], ["MNE2", "0"], ["SE1", "0"], ["MNE3", "0"], ["MNE4", "0"], ["MNE5", "0"], ["NE3", "0"], ["MNE6", "0"], ["SE2", "0"], ["MNE7", "0"], ["GE1", "0"], ["NE4", "0"], ["GE2", "0"]]
