local Translations = {
    notifications = {
        ["char_deleted"] = "Character deleted!",
        ["deleted_other_char"] = "You successfully deleted the character with citizen id %{citizenid}.",
        ["forgot_citizenid"] = "You forgot to input a citizen id!",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Deletes another players character",
        ["citizenid"] = "Citizen ID",
        ["citizenid_help"] = "The Citizen ID of the character you want to delete",

        --Loaded
       

        -- /logout
        ["logout_description"] = "Logout of Character (Admin Only)",

        -- /closeNUI
        ["closeNUI_description"] = "Close Multi NUI"
    },

    misc = {
        ["succes_loaded"] = '^2[qb-core]^7 %{value} has succesfully loaded!',
        ["droppedplayer"] = "You have disconnected from QBCore"
    },

    ui = {
        -- Main
        male = "Male",
        female = "Female",
        error_title = "Error!",
        characters_header = "Character Selector",
        characters_count = "characters",
      
         --Setup Characters
        default_image = 'https://images-ext-1.discordapp.net/external/6V7wC4F8ZsnyrauCUcFUvpIIMxtW4jKjec_suTpDexI/https/cdn.sforum.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg?format=webp&width=670&height=670', --You can 'assets/yourimage.png' or any put "any link you want"
       create_new_character = "Create new character",
       default_right_image = 'assets/image2.png', --You can 'assets/yourimage.png' or any put "any link you want"

        --Create character
        create_header = "Identity Creation",
        header_detail = "Enter your character detalls",
        gender_marker = "Gender Marker",
        
        missing_information = "You wrote missing information.",
        badword = "You have used a bad word, try again!",
       
        create_firstname = "Name",
        create_lastname = "Lastname",
        create_nationality = "Nationality",
        create_birthday = "Birthday",

        -- Buttons
        select = "Select",
        create = "Create",
        spawn = "Spawn",
        delete = "Delete",
        cancel = "Cancel",
        confirm = "Confirm",
        close = "Close",}

}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
