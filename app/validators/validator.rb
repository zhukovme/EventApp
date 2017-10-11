class Validator
  include ActiveModel::Validations

  def reason
    errors.full_messages[0]
  end
end
