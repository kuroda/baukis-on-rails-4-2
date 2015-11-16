class DateStringValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    Date.parse(value) if value.present?
  rescue ArgumentError
    record.errors.add(attribute, :invalid)
  end
end
