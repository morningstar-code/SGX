var inventory = [];
var config = {};
var phoneConfig = {};
var playerExperience = {};
var npcID;

$(document).ready(function() {
    window.addEventListener('message', function(event) {
        var data = event.data;

        switch (data.action) {
            case 'toggleNPCSellNUI':
                if (data.translations) {
                    setTranslation(data.translations)
                }

                if (data.inventory) {
                    loadInventory(data.inventory);
                }

                if (data.playerExperience) {
                    playerExperience = data.playerExperience
                    loadPlayerExperience(data.playerExperience);
                }

                if (data.config) {
                    config = data.config
                }

                if (data.npcID) {
                    npcID = data.npcID
                }

                toggleNPCSellUI(data.showNUI);
                break;
            case 'togglePhoneNUI':
                if (data.translations) {
                    setTranslation(data.translations);
                }

                if (data.playerExperience) {
                    loadPlayerExperiencePhone(data.playerExperience);
                }

                if (data.mole) {
                    generateAndDisplaySubscriptions(data.mole);
                }

                if (data.settings) {
                    loadPlayerSettings(data.settings);
                }

                if (data.config) {
                    phoneConfig = data.config
                }

                togglePhoneUI(data.showNUI);
                break;
            case 'addPhoneConversation':
                if (data.translations) {
                    setTranslation(data.translations);
                }

                createMessageWithJQuery(data.npcID, data.itemName);
                break;
            case 'sendPhoneMessage':

                addMessageToConversation(data.npcID, data.itemName, false);
                break;
            case 'sendMolePhoneMessage':
                addMessageToConversationMole(data.moleName, data.text, false)

                break;
            case 'showModal':

                showModal(data.title, data.text)
                break;
        }
    });
});

function setRespectProgress(respect, respectLimit) {
    const percent = (respect / respectLimit) * 100; // Obliczenie procentu
    const circumference = 2 * Math.PI * 45;
    const offset = circumference - (percent / 100) * circumference;
    $('.progress-circle-bar-respect').css('strokeDashoffset', offset);
}

function setSalesProgress(sales, salesLimit) {
    const percent = (sales / salesLimit) * 100; // Obliczenie procentu
    const circumference = 2 * Math.PI * 45;
    const offset = circumference - (percent / 100) * circumference;
    $('.progress-circle-bar-sales').css('strokeDashoffset', offset);
}

function loadPlayerExperience(data) {
    setRespectProgress(data.respect, data.respectLimit)
    setSalesProgress(data.sales, data.salesLimit)
}

$('#progress-respect').mouseenter(function(e) {
    updateTooltip( translate("dialog_respect_tooltip", playerExperience.respect, playerExperience.respectLimit), e);
}).mousemove(function(e) {
    updateTooltip( translate("dialog_respect_tooltip", playerExperience.respect, playerExperience.respectLimit), e); // Aktualizacja pozycji przy ruchu myszki
}).mouseleave(function() {
    hideTooltip();
});

// Obsługa tooltip dla Progress Bar Sales
$('#progress-sales').mouseenter(function(e) {
    updateTooltip( translate("dialog_sales_skill_tooltip", playerExperience.sales, playerExperience.salesLimit), e);
}).mousemove(function(e) {
    updateTooltip( translate("dialog_sales_skill_tooltip", playerExperience.sales, playerExperience.salesLimit), e); // Aktualizacja pozycji przy ruchu myszki
}).mouseleave(function() {
    hideTooltip();
});

function toggleNPCSellUI(show) {
    if (show) {
        selectedItemName = null;
        loadDialog("start");

        $('.npcSell-background').fadeIn(200);
        $('#npcSell-container').css('display', 'flex').hide().fadeIn(200);
    } else {
        $('#dialog-backpack-container').hide();
        $('#dialog-interactive-arrow').hide();
        $('#dialog-title').hide();

        $('#npcSell-container').fadeOut(200);
        $('.npcSell-background').fadeOut(200);
    }
}


function loadInventory(inventoryItems) {
    inventory = inventoryItems;
    var backpackContainer = $("#dialog-backpack-container");
    backpackContainer.find(".dialog-backpack-item").remove();

    inventory.forEach(function(item) {
        var itemDiv = $("<div class='dialog-backpack-item'></div>");
        var itemName = $("<h2>").text(item.label);
        itemDiv.append(itemName);
        itemDiv.append($("<img>").attr("src", item.img));
        itemDiv.append($("<p>").text(item.amount));

        // Dodajemy obsługę kliknięcia na element ekwipunku
        itemDiv.click(function() {
            selectInventoryItem(item.name, item.label, item.amount);
        });


        itemName.mouseenter(function(e) {
            updateTooltip(item.label, e, true);
        }).mousemove(function(e) {
            updateTooltip(item.label, e, true); // Aktualizacja pozycji przy ruchu myszki
        }).mouseleave(function() {
            hideTooltip();
        });

        backpackContainer.append(itemDiv);
    });
}

function updateTooltip(text, event, alignRight) {
    var tooltip = $('.custom-tooltip');
    tooltip.text(text).show();

    var tooltipX = alignRight ? event.clientX + 20 : event.clientX - tooltip.width() - 60;
    var tooltipY = event.clientY + 20;

    tooltip.css({
        top: tooltipY,
        left: tooltipX
    });
}

// Funkcja do ukrywania tooltipa
function hideTooltip() {
    $(".custom-tooltip").hide();
}

var selectedItemName;
var selectedItemLabel;
function selectInventoryItem(itemName, itemLabel, drugQuantity) {
    if (selectedItemName === itemName) {
        return;
    }

    var selectedItem = dialogs[currentDialogId].responses.find(function(response) {
        return response.isSelectable;
    });

    if (selectedItem) {
        $('#arrow-for-select-item').fadeOut();

        var coloredItemName = "<span class='itemNameColor'>" + itemLabel + "</span>";
        $("#dialog-player-first-answer .dialog-data-text").html(randomTranslate("dialog_answer_sale_offer", coloredItemName));
        selectedItem.isSelected = true; // Oznaczenie, że element został wybrany 
        selectedItem.drugQuantity = drugQuantity
        selectedItemName = itemName
        selectedItemLabel = itemLabel
    }
}

// Funkcja pomocnicza do skracania nazwy
function shortenName(name, maxLength) {
    if (name.length > maxLength) {
        return name.substring(0, maxLength) + "...";
    } else {
        return name;
    }
}

var animationInProgress = false;
$('#dialog-interactive-backpack').click(function(e) {
    if (inventory.length === 0) {
        $(this).effect("shake", { distance: 1, times: 2 }, 300);
    } else if (!animationInProgress) {
        animationInProgress = true;

        var backpackContainer = $('#dialog-backpack-container');
        if (backpackContainer.is(':hidden')) {
            backpackContainer.css('display', 'flex').hide().slideDown(300, function() {
                $('#dialog-title').fadeToggle(200);
                animationInProgress = false;
            });
        } else {
            $('#dialog-title').fadeToggle(200);
            backpackContainer.slideUp(300, function() {
                $(this).css('display', 'none');
                animationInProgress = false;
            });
        }

        $('#dialog-interactive-arrow').fadeToggle(300);
    }
});

// MAIN
var currentDialogId = 'start';
var dialogs = {
    start: {
        npcText: "dialog_npc_first_message",
        responses: [
            { type: "normal", text: "dialog_answer_start_normal", action: null, nextDialogId: "whatYouHave" },
            { type: "exit", text: "dialog_answer_start_exit", action: "exit", nextDialogId: null },    
        ]
    },
    whatYouHave: {
        npcText: "dialog_npc_whatYouHave",
        responses: [
            { type: "normal", text: "dialog_answer_sale_offer", action: null, nextDialogId: 'randomizeSuccess', isSelectable: true },
            { type: "exit", text: "dialog_answer_whatYouHave_exit", action: "exit", nextDialogId: null }
        ]
    },
    iWillTake: {
        npcText: "dialog_npc_take",
        responses: [
            { type: "write", text: "dialog_answer_iWillTake_write", action: "price", nextDialogId: null },
            { type: "normal", text: "dialog_answer_iWillTake_normal", action: null, nextDialogId: "whatYouHave" },
            { type: "exit", text: "dialog_answer_iWillTake_exit", action: "exit", nextDialogId: null }
        ]
    },
    giveMeBetterOption: {
        npcText: "dialog_npc_giveMeBetterOption",
        responses: [
            { type: "write", text: "dialog_answer_iWillTake_write", action: "price", nextDialogId: null },
            { type: "normal", text: "dialog_answer_iWillTake_normal", action: null, nextDialogId: "whatYouHave" },
            { type: "exit", text: "dialog_answer_iWillTake_exit", action: "exit", nextDialogId: null }
        ]
    },
    noThanks: {
        npcText: "dialog_npc_noThanks",
        responses: [
            { type: "exit", text: "dialog_answer_noThanks_exit", action: "exit", nextDialogId: null, reset: true }
        ]
    },
    sellSuccess: {
        npcText: "dialog_npc_sellSuccess",
        responses: [
            { type: "normal", text: "dialog_answer_sellSuccess_normal", action: "exit", nextDialogId: null, endInteraction: true }
        ]
    },
    sellFail: {
        npcText: "dialog_npc_sellFail",
        responses: [
            { type: "exit", text: "dialog_answer_exit", action: "exit", nextDialogId: null}
        ]
    },
};

function setDialogHeader(title, subtitle) {
    $('#dialog-header h2').text(title);
    $('#dialog-header p').text(subtitle);
}

function typeWriter($element, text, index, typingSpeed, callback) {
    if (index < text.length) {
        $element.append(text.charAt(index));
        setTimeout(function() {
            typeWriter($element, text, index + 1, typingSpeed, callback);
        }, typingSpeed);
    } else if (callback) {
        callback();
    }
}

var isTyping = false;
function updateNpcText(text) {
    var $npcTextBox = $('#dialog-npc-box .dialog-data-text');
    $npcTextBox.empty();

    var typingSpeed = 25; // Szybkość "pisywania" w milisekundach na literę
    isTyping = true;

    typeWriter($npcTextBox, text, 0, typingSpeed, function() {
        isTyping = false; // Zakończenie "pisywania"
    });
}


function createStandardData(npcText) {
    // Header
    var $dialogHeader = $("<div>", { id: "dialog-header" });
    $dialogHeader.append($("<h2>").text(translate("dialog_stranger_title")));
    $dialogHeader.append($("<p>").text(`#${npcID}`));

    $("#dialog").append($dialogHeader);


    // NPC TEXT
    var $dialogNpcBox = $("<div>", { id: "dialog-npc-box" });
    $dialogNpcBox.append($("<img>", { class: "dialog-icon dialog-icon-blue", src: "img/chat.png" }));
    $dialogNpcBox.append($("<p>", { class: "dialog-data-text" }).text(randomTranslate("dialog_npc_first_message")));

    $("#dialog").append($dialogNpcBox);
    
    updateNpcText(npcText);
}

var sellPriceValue;
function updateResponses(npcText, responses) {
    $("#dialog").empty();

    createStandardData(npcText)

    // RESPONSES 
    responses.forEach(function(response, index) {
        var responseText = randomTranslate(response.text); 

        if (index < 2) {
            // Dla pierwszej i drugiej odpowiedzi
            var responseDivId = 'dialog-player-' + (index === 0 ? 'first' : 'second') + '-answer';
            var iconClass, iconSrc;

            if (response.type === 'exit') {
                iconClass = 'dialog-icon-red';
                iconSrc = 'img/cancel.png';
            } else if (response.type === 'write') {
                iconClass = 'dialog-icon-write'; // Przykładowa klasa dla 'write'
                iconSrc = 'img/write.png'; // Przykładowy obraz dla 'write'
            } else { // Domyślnie dla 'normal' i innych
                iconClass = 'dialog-icon-green';
                iconSrc = 'img/chat.png';
            }

            var responseDiv = $("<div>", { id: responseDivId, class: "dialog-player-answer" });
            responseDiv.append($("<img>", { class: "dialog-icon " + iconClass, src: iconSrc }));

            if (response.type === 'write') {
                var placeholderText = responseText;
                var inputField = $("<input>", { 
                    type: "number", 
                    class: "dialog-input-field",
                    placeholder: placeholderText,
                    min: "1",
                    step: "1"
                });
                var confirmIcon = $("<img>", {
                    class: "dialog-confirm-icon",
                    src: "img/correct.png",
                    click: function() {
                        var inputValue = inputField.val();
                        var numericValue = parseInt(inputValue);
                    
                        if (!isNaN(numericValue) && numericValue.toString() === inputValue && numericValue >= 1) {
                            $.post('https://sgx-selldrugs/dialogBack', JSON.stringify({ action: "sell", itemName: selectedItemName, inputValue: numericValue, isWholesale: false }))
                                .done(function(response) {
                                    if (response.result) {
                                        sellPriceValue = numericValue;
                                        loadDialog("sellSuccess");
                                    } else {
                                        if (response.totalNegotiation < 3) {
                                            loadDialog("giveMeBetterOption");
                                        } else {
                                            loadDialog("sellFail");
                                        }
                                    }
                                })
                        } else {
                            Notify(translate("notify_input_wrong"), "error", 2500)
                        }
                    }
                });
        
                responseDiv.append(inputField);
                responseDiv.append(confirmIcon);
            } else {
                responseDiv.append($("<p>", { class: "dialog-data-text" }).text(responseText));
                responseDiv.addClass("hover-effect");
            }

            // click
            if (response.type !== "write") {
                responseClick(responseDiv, response)
            }
    
            if (index === 0) {
                var firstRowDiv = $("<div>", { id: "dialog-player-box-first-row" });
                firstRowDiv.append(responseDiv);
                $("#dialog").append(firstRowDiv);
            } else {
                $("#dialog-player-box-first-row").append(responseDiv);
            }

        } else if (index === 2) {
            // Dla trzeciej odpowiedzi
            var thirdResponseDiv = $("<div>", { id: "dialog-player-third-answer", class: "dialog-player-answer hover-effect" });
            thirdResponseDiv.append($("<img>", { class: "dialog-icon dialog-icon-red", src: "img/cancel.png" }));
            thirdResponseDiv.append($("<p>", { class: "dialog-data-text" }).text(responseText));

            // click
            responseClick(thirdResponseDiv, response)
    
            $("#dialog").append(thirdResponseDiv);
        }
    });
}

function setProductPriceForNPC(itemName, drugQuantity) {
    const maxQuantity = Math.min(drugQuantity, config.maxQuantity);
    npcQuantity[itemName] = Math.floor(Math.random() * maxQuantity) + 1;
}

var quantityToSell;
var itemToSellName;
var npcQuantity = {};
function responseClick(element, response) {
    element.click(function() {
        if (!isTyping) {
            // backpack select
            if (response.isSelectable && !response.isSelected) {
                // Jeśli odpowiedź jest zależna od wyboru i nie została jeszcze wybrana
                Notify(translate("notify_inventory_select"), "error", 2500)
                return; // Przerwij obsługę kliknięcia
            }

            // load next dialog
            if (response.nextDialogId !== null) {

                if (response.nextDialogId == 'randomizeSuccess') {
                    itemToSellName = selectedItemName


                    if (Math.random() < config.InterestInDrugs / 100) {
                        setProductPriceForNPC(itemToSellName, response.drugQuantity); 
    
                        // dialogs['iWillTake'].npcText = randomTranslate("dialog_npc_take", npcQuantity[itemToSellName], itemToSellName);
                        response.nextDialogId = 'iWillTake';
                    } else {
                        response.nextDialogId = 'noThanks';
                    }

                    var backpackContainer = $('#dialog-backpack-container');
                    if (backpackContainer.is(':visible')) {
                        $('#dialog-interactive-backpack').click();
                    }

                    // dialogs["whatYouHave"].responses[0].text = randomTranslate("dialog_answer_sale_offer")
                    response.isSelected = false
                } 

                if (response.nextDialogId == 'whatYouHave') {
                    dialogs["whatYouHave"].responses[0].nextDialogId = "randomizeSuccess"
                }

                loadDialog(response.nextDialogId);

            } 

            // action to lua
            if (response.action !== null) {

                if (response.endInteraction !== null && response.endInteraction) {
                    $.post('https://sgx-selldrugs/successInteraction', JSON.stringify({ itemName: itemToSellName, amount: npcQuantity[itemToSellName], price: sellPriceValue }))
                } else {
                    $.post('https://sgx-selldrugs/dialogBack', JSON.stringify({ action: response.action }))
                }

                if (response.action == 'exit') {
                    npcQuantity = {};
                }

            }

        }
    });
}

function loadDialog(dialogId) {
    if (dialogs[dialogId]) {
        currentDialogId = dialogId

        if (dialogId == "whatYouHave") {
            $('#arrow-for-select-item').fadeIn();
        } else {
            $('#arrow-for-select-item').fadeOut();
        }

        var npcText;

        if (dialogId == "iWillTake") {
            npcText = randomTranslate(dialogs[dialogId].npcText, npcQuantity[itemToSellName], selectedItemLabel);
        } else {
            npcText = randomTranslate(dialogs[dialogId].npcText)
        }
        updateResponses(npcText, dialogs[dialogId].responses);
    }
}

function translate(key, ...args) { // -- translate: Replace placeholders (%s) in a translation key with args; remove unused placeholders.
    if (translations[key]) {
        let result = translations[key];
        args.forEach((arg, index) => {
            result = result.replace(/%s/, arg === undefined ? '' : arg);
        });
        result = result.replace(/%s/g, '');
        return result;
    } else {
        return `Translation missing for key: ${key}`;
    }
}

function randomTranslate(key, ...args) { // -- randomTranslate: Choose a random translation under key, replace (%s) with args; remove unused placeholders.
    if (translations["randomTexts"] && translations["randomTexts"][key]) {
        const texts = translations["randomTexts"][key];
        const randomIndex = Math.floor(Math.random() * texts.length);
        let result = texts[randomIndex];

        args.forEach((arg, index) => {
            result = result.replace(/%s/, arg === undefined ? '' : arg);
        });
        result = result.replace(/%s/g, '');

        return result;
    } else {
        return `No random texts available for key: ${key}`;
    }
}

