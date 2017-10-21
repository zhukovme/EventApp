class Validator
  include ActiveModel::Validations

  def validate_array(array)
    array.map(&:strip) if array.present? && array.is_a?(Array)
  end

  def validate_int(int)
    int.strip if int?(int)
  end

  def int?(string)
    true if Integer(string) rescue false
  end

  def reason
    errors.full_messages[0]
  end
end
