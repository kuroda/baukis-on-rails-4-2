if ActiveRecord::Base.connection.tables.include?('application_settings')
  ApplicationSetting.count == 0
  ApplicationSetting.create!(
    application_name: 'Baukis',
    session_timeout: 60
  )
end
