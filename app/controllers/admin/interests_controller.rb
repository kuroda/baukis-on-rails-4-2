class Admin::InterestsController < Admin::Base

  # GET /interests
  def index
    @search_form = Admin::InterestSearchForm.new(params[:search])
    @interests = @search_form.search.page(params[:page])
  end

  # GET /interests/new
  def new
    @interest_form = Admin::InterestForm.new
  end

  # GET /interests/1/edit
  def edit
    @interest_form = Admin::InterestForm.new(Interest.find(params[:id]))
  end

  # POST /interests
  def create
    @interest_form = Admin::InterestForm.new
    @interest_form.assign_attributes(params[:form])
    if @interest_form.save
      flash.notice = '顧客を追加しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  # PATCH/PUT /interests/1
  def update
    @interest_form = Admin::InterestForm.new(Interest.find(params[:id]))
    @interest_form.assign_attributes(params[:form])
    if @interest_form.save
      flash.notice = 'プログラムを更新しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'edit'
    end
  end

  # DELETE /interests/1
  def destroy
    interest = Interest.find(params[:id])
    if interest.destroy
      flash.notice = 'プログラムを更新しました'
    else
      flash.alert = '入力に誤りがあります。'
    end

    redirect_to :admin_interests
  end
end
