def check_pan_card 
    pan_card = PanCard.find_by_username(current_user.username)
    if pan_card == nil
        print pan_card
        redirect_to "/user"
    end
end
