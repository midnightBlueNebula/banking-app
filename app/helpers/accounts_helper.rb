module AccountsHelper
    def interest_convert(value, currency_base, currency_target)
        if currency_target == "dolar"
            if currency_base == "euro"
                value * 1.22
            elsif currency_base == "sterlin"
                value * 1.34
            elsif currency_base == "tl"
                value * 0.12
            elsif currency_base == "yen"
                value * 0.0096
            elsif currency_base == "dollar"
                value 
            end
        elsif currency_base == "dolar"
            if currency_target == "euro"
                value / 1.22
            elsif currency_target == "sterlin"
                value / 1.34
            elsif currency_target == "tl"
                value / 0.12
            elsif currency_target == "yen"
                value / 0.0096
            elsif currency_target == "dollar"
                value 
            end
        else
            temp_val = interest_convert(value, currency_base, "dolar")
            interest_convert(temp_val, "dolar", currency_target)
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
