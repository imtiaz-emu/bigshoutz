class AddCurrencyToAddOnTable < ActiveRecord::Migration[6.1]
  def change
    add_column :addons, :currency, :string, default: 'MYR'
  end
end
