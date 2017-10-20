class Validator
  include ActiveModel::Validations

  def nil_or_not_blank?(param)
    param.nil? || !param.blank?
  end

  def reason
    errors.full_messages[0]
  end
end
