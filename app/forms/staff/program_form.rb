class Staff::ProgramForm
  include ActiveModel::Model

  attr_accessor :program
  delegate :persisted?, :save, to: :program

  def initialize(program = nil)
    @program = program
    @program ||= Program.new
    if @program.application_start_time
      @program.application_start_date =
        @program.application_start_time.to_date.to_s
      @program.application_start_hour =
        sprintf('%02d', @program.application_start_time.hour)
      @program.application_start_minute =
        sprintf('%02d', @program.application_start_time.min)
    else
      @program.application_start_hour = '09'
      @program.application_start_minute = '00'
    end
    if @program.application_end_time
      @program.application_end_date =
        @program.application_end_time.to_date.to_s
      @program.application_end_hour =
        sprintf('%02d', @program.application_end_time.hour)
      @program.application_end_minute =
        sprintf('%02d', @program.application_end_time.min)
    else
      @program.application_end_hour = '17'
      @program.application_end_minute = '00'
    end
  end

  def assign_attributes(params = {})
    @params = params
    program.assign_attributes(program_params)
  end

  private
  def program_params
    @params.require(:program).permit(
      :title, :description, :application_start_date, :application_start_hour,
      :application_start_minute, :application_end_date, :application_end_hour,
      :application_end_minute, :min_number_of_participants,
      :max_number_of_participants
    )
  end
end
