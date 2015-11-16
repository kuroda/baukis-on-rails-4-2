class Staff::EntriesForm
  include ActiveModel::Model

  attr_accessor :program, :approved, :not_approved, :canceled, :not_canceled

  def initialize(program)
    @program = program
  end

  def assign_attributes(params)
    @approved = params[:approved]
    @not_approved = params[:not_approved]
    @canceled = params[:canceled]
    @not_canceled = params[:not_canceled]
  end

  def save
    approved_entry_ids = @approved.split(':').map(&:to_i)
    not_approved_entry_ids = @not_approved.split(':').map(&:to_i)
    canceled_entry_ids = @canceled.split(':').map(&:to_i)
    not_canceled_entry_ids = @not_canceled.split(':').map(&:to_i)

    ActiveRecord::Base.transaction do
      @program.entries.where(id: approved_entry_ids).
        update_all(approved: true)
      @program.entries.where(id: not_approved_entry_ids).
        update_all(approved: false)
      @program.entries.where(id: canceled_entry_ids).
        update_all(canceled: true)
      @program.entries.where(id: not_canceled_entry_ids).
        update_all(canceled: false)
    end
  end
end
