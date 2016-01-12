class Admin::InterestForm
  include ActiveModel::Model

  attr_accessor :interest
  delegate :persisted?, :save, to: :interest

  def initialize(interest = nil)
    @interest = interest
    @interest ||= Interest.new(title: '')
  end

  def assign_attributes(params = {})
    @params = params
    interest.assign_attributes(interest_params)
  end

  private
  def interest_params
    @params.require(:interest).permit(:title)
  end
end
