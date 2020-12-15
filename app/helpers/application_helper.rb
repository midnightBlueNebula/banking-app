module ApplicationHelper
    def back_or(arg_url)
        if arg_url.nil?
            redirect_back(fallback_location: root_url)
        else
            redirect_back(fallback_location: arg_url)
        end
    end
end
