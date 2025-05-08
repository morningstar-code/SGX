var translations;

var isTranslationSet = false;
function setTranslation(newTranslations) {
    if (isTranslationSet) return

    translations = newTranslations
    isTranslationSet = true

    // HTML
    $("#dialog-title").text(translate("dialog_inventory_title"))

    $("#tel-app-messages-title").text(translate("phone_messages_title"))
    $("#tel-app-ogapp-title").text(translate("phone_ogApp_title"))
    $("#tel-app-settings-title").text(translate("phone_settings_title"))

    $("#ogApp-respect-title").text(translate("phone_ogApp_respect_title"))
    $("#ogApp-selling-skill-title").text(translate("phone_ogApp_selling_skill_title"))
    $("#ogApp-active-subscriptions-title").text(translate("phone_ogApp_active_subscriptions_title"))

    $("#settings-alerts-title").text(translate("phone_setting_alerts"))
    $("#settings-alerts-sound-title").text(translate("phone_setting_alerts_sound"))
}