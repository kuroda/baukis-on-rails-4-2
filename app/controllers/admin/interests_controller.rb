class Admin::InterestsController < Admin::Base

  # GET /interests
  def index
    @interests = Interest.all
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
      flash.notice = '興味・関心を新たに追加しました。'
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
      flash.notice = '興味・関心を修正しました。'
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
      flash.notice = '興味・関心を削除しました。'
    else
      flash.alert = '興味・関心は２つ以上にしてください。'
    end

    redirect_to :admin_interests
  end
end
