module AddonsHelper
  def currency_list
    Money::Currency.table.each_with_object([]) do |currency, memo|
      memo << {
          code: currency.last.dig(:iso_code),
          name:  "#{currency.last.dig(:name)} (#{currency.last.dig(:iso_code)})"
      }
    end
  end
end
