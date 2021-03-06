class BikeCreatorVerifier
  def initialize(b_param = nil, bike = nil)
    @b_param = b_param
    @bike = bike 
  end

  def set_no_payment_required
    @bike.payment_required = false
    @bike.verified = true
  end

  def check_token
    @bike = BikeCreatorTokenizer.new(@b_param, @bike).tokenized_bike
  end

  def check_organization
    @bike = BikeCreatorOrganizer.new(@b_param, @bike).organized_bike
  end

  def stolenize
    @bike.stolen = true 
    @bike.payment_required = false 
  end

  def check_stolen
    if @b_param.params[:stolen]
      stolenize
    elsif @b_param.params[:bike].present? and @b_param.params[:bike][:stolen]
      stolenize
    end
  end

  def verify
    set_no_payment_required
    check_token
    check_organization
    check_stolen
    @bike
  end

end