module OperationsHelper
  def sanitize_params(operation)
    params_hash = operation.attributes
    value = (params_hash['value_cents'].abs / 100.00).to_s

    rejected_params = ['id', 'created_at', 'operation_id',
                       'updated_at', 'value_currency', 'value_cents']

    rejected_params.each do |param|
      params_hash.delete(param)
    end

    params_hash = params_hash.merge({ 'value' => value, 'paid_at' => Date.current })
    params_hash
  end
end
