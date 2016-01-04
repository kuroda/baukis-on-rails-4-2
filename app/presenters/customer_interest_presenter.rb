class CustomerInterestPresenter < ModelPresenter
  def title
    object.interest.title
  end
end
