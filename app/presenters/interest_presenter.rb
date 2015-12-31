class InterestPresenter < ModelPresenter
  delegate :title, to: :object
end
