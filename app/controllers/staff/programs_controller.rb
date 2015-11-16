class Staff::ProgramsController < Staff::Base
  def index
    @programs = Program.listing.page(params[:page])
  end

  def show
    @program = Program.listing.find(params[:id])
  end

  def new
    @program_form = Staff::ProgramForm.new
  end

  def edit
    @program_form = Staff::ProgramForm.new(Program.find(params[:id]))
  end

  def create
    @program_form = Staff::ProgramForm.new
    @program_form.assign_attributes(params[:form])
    @program_form.program.registrant = current_staff_member
    if @program_form.save
      flash.notice = 'プログラムを登録しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def update
    @program_form = Staff::ProgramForm.new(Program.find(params[:id]))
    @program_form.assign_attributes(params[:form])
    if @program_form.save
      flash.notice = 'プログラムを更新しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'edit'
    end
  end

  def destroy
    program = Program.find(params[:id])
    if program.deletable?
      program.destroy!
      flash.notice = 'プログラムを削除しました。'
    else
      flash.alert = 'このプログラムは削除できません。'
    end
    redirect_to :staff_programs
  end

  # PATCH
  def entries
    entries_form = Staff::EntriesForm.new(Program.find(params[:id]))
    entries_form.assign_attributes(params[:form])
    entries_form.save
    flash.notice = 'プログラム申し込みのフラグを更新しました。'
    redirect_to :staff_programs
  end
end
