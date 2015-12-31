class Staff::InterestSearchForm
  include ActiveModel::Model

  attr_accessor :title

  def search
    rel = Interest
    if title.present?
      rel = rel.where(title: title)
    end

    rel = rel.distinct
    rel.order(:title)
  end
end
