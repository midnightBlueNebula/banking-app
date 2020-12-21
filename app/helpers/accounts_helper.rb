module AccountsHelper
    def interest_convert(value, base_currency, target_currency)
        if target_currency == "dolar"
            if base_currency == "euro"
                value * 1.22
            elsif base_currency == "sterlin"
                value * 1.34
            elsif base_currency == "tl"
                value * 0.12
            elsif base_currency == "yen"
                value * 0.0096
            elsif base_currency == "dollar"
                value 
            end
        elsif base_currency == "dolar"
            if target_currency == "euro"
                value / 1.22
            elsif target_currency == "sterlin"
                value / 1.34
            elsif target_currency == "tl"
                value / 0.12
            elsif target_currency == "yen"
                value / 0.0096
            elsif target_currency == "dollar"
                value 
            end
        else
            temp_val = interest_convert(value, base_currency, "dolar")
            interest_convert(temp_val, "dolar", target_currency)
        end
    end

    def calculate_interest(value, currency)
        if interest_convert(value, currency, "dolar") < 10000
            0.75
        elsif interest_convert(value, currency, "dolar") >= 10000 && 
            interest_convert(value, currency, "dolar") < 50000
            1.25
        elsif interest_convert(value, currency, "dolar") >= 50000 && 
            interest_convert(value, currency, "dolar") < 100000
            1.75
        elsif interest_convert(value, currency, "dolar") >= 100000
            2.5
        end 
    end

    def close_account(account_to_close, account_to_transfer)
        if account_to_close.currency == account_to_transfer.currency
            account_to_transfer.balance += account_to_close.balance
            account_to_close.balance = 0.00
        else
            value = interest_convert(account_to_close.balance, 
                                     account_to_close.currency,
                                     account_to_transfer.currency)

            account_to_transfer.balance += value
            account_to_close.balance = 0.00
        end
    end
end
