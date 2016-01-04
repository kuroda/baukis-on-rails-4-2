class Customer::AccountForm
  include ActiveModel::Model

  attr_accessor :customer, :inputs_home_address, :inputs_work_address
  delegate :persisted?, :valid?, :save, to: :customer

  def initialize(customer)
    @customer = customer
    (2 - @customer.personal_phones.size).times do
      @customer.personal_phones.build
    end
    self.inputs_home_address = @customer.home_address.present?
    self.inputs_work_address = @customer.work_address.present?
    @customer.build_home_address unless @customer.home_address
    @customer.build_work_address unless @customer.work_address
    (2 - @customer.home_address.phones.size).times do
      @customer.home_address.phones.build
    end
    (2 - @customer.work_address.phones.size).times do
      @customer.work_address.phones.build
    end

    unchecked_interests = Interest.where('id NOT IN (?)', @customer.interests.pluck(:id))
    (Interest.all.size - @customer.interests.size).times do |index|
      if unchecked_interests.size == 0
        unchecked_interests = Interest.all
        @customer.customer_interests.build(interest_id: unchecked_interests[index].id)
      else
        @customer.customer_interests.build(interest_id: unchecked_interests[index].id)
      end
    end
  end

  def assign_attributes(params = {})
    @params = params
    self.inputs_home_address = params[:inputs_home_address].in? [ '1', 'true' ]
    self.inputs_work_address = params[:inputs_work_address].in? [ '1', 'true' ]

    customer.assign_attributes(customer_params)

    phones = phone_params(:customer).fetch(:phones)
    customer.personal_phones.size.times do |index|
      attributes = phones[index.to_s]
      if attributes && attributes[:number].present?
        customer.personal_phones[index].assign_attributes(attributes)
      else
        customer.personal_phones[index].mark_for_destruction
      end
    end

    if inputs_home_address
      customer.home_address.assign_attributes(home_address_params)

      phones = phone_params(:home_address).fetch(:phones)
      customer.home_address.phones.size.times do |index|
        attributes = phones[index.to_s]
        if attributes && attributes[:number].present?
          customer.home_address.phones[index].assign_attributes(attributes)
        else
          customer.home_address.phones[index].mark_for_destruction
        end
      end
    else
      customer.home_address.mark_for_destruction
    end
    if inputs_work_address
      customer.work_address.assign_attributes(work_address_params)

      phones = phone_params(:work_address).fetch(:phones)
      customer.work_address.phones.size.times do |index|
        attributes = phones[index.to_s]
        if attributes && attributes[:number].present?
          customer.work_address.phones[index].assign_attributes(attributes)
        else
          customer.work_address.phones[index].mark_for_destruction
        end
      end
    else
      customer.work_address.mark_for_destruction
    end

    customer_interests = customer_interests_params(:customer).fetch(:customer_interests)
    customer.customer_interests.size.times do |index|
      attributes = customer_interests[index.to_s]
      if attributes && attributes[:checked] == '1'
        customer.customer_interests[index].assign_attributes(attributes.except(:checked))
      else
        customer.customer_interests[index].mark_for_destruction
      end
    end
  end

  private
  def customer_params
    @params.require(:customer).permit(
      :family_name, :given_name, :family_name_kana, :given_name_kana,
      :birthday, :gender, :job_title
    )
  end

  def home_address_params
    @params.require(:home_address).permit(
      :postal_code, :prefecture, :city, :address1, :address2,
    )
  end

  def work_address_params
    @params.require(:work_address).permit(
      :postal_code, :prefecture, :city, :address1, :address2,
      :company_name, :division_name
    )
  end

  def phone_params(record_name)
    @params.require(record_name).permit(phones: [ :number, :primary ])
  end

  def customer_interests_params(record_name)
    @params.require(record_name).permit(customer_interests: [ :checked ])
  end
end
