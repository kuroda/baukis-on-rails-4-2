class CustomerPresenter < ModelPresenter
  def emails
    if object.emails.many?
      markup(:ul) do |m|
        object.emails.each do |email|
          m.li email.address
        end
      end
    else
      object.emails.first.try(:address)
    end
  end

  def full_name
    object.family_name + ' ' + object.given_name
  end

  def full_name_kana
    object.family_name_kana + ' ' + object.given_name_kana
  end

  def birthday
    return '' if object.birthday.blank?
    object.birthday.strftime('%Y/%m/%d')
  end

  def gender
    case object.gender
    when 'male'
      '男性'
    when 'female'
      '女性'
    else
      ''
    end
  end

  def personal_phones
    object.personal_phones.map(&:number)
  end
end
