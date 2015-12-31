class InterestPresenter < ModelPresenter
  delegate :title, to: :object
  delegate :checkbox, to: :view_context

  def interest_check_box
    markup(:div, class: 'input-block') do |m|
      m << check_box(:title)
      m << label(:title, 'アカウント停止')
    end
  end
end