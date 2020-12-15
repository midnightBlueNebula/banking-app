module AccountsHelper
    def in_dollar(value, currency)
        if currency == "euro"
            value * 1.22
        elsif currency == "sterlin"
            value * 1.34
        elsif currency == "tl"
            value * 0.12
        elsif currency == "yen"
            value * 0.0096
        elsif currency == "dollar"
            value 
        end
    end

    def calculate_interest(value, currency)
        if in_dollar(value, currency) < 10000
            0.75
        elsif in_dollar(value, currency) >= 10000 && 
              in_dollar(value, currency) < 50000
            1.25
        elsif in_dollar(value, currency) >= 50000 && 
              in_dollar(value, currency) < 100000
            1.75
        elsif in_dollar(value, currency) >= 100000
            2.5
        end 
    end
end
