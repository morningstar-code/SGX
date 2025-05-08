var isPhoneVisibleForNotification = false;
function togglePhoneUI(show) {
    if (show) {
        isPhoneVisibleForNotification = false;
        $("#telephone-container").stop().css('display', 'block').animate({
            bottom: '1vw'
        }, 1000);
    } else {
        $("#telephone-container").stop().animate({
            bottom: '-60%'
        }, 1000, function() {
            $(this).css('display', 'none');
        });
        $.post('https://sgx-selldrugs/phoneExit');
    }
}

$(document).keydown(function(e) {
    if (e.keyCode === 27) { 
        if ($("#telephone-container").is(":visible")) {
            togglePhoneUI(false);
        }
    }
});

var currentDisplayedConversationId;

$('.menu-icon').click(function() {
    var targetWindow = $(this).data('target');
    $('.menu-window').hide(); 
    $(targetWindow).show();

    if (targetWindow === '#messages-window') {
        resetNewMessagesCount();
    }
});

$('#telephone-button-menu, #telephone-button-back').click(function() {
    if ($('#menu').is(':visible') || blurActive) {
        return;
    }

    $('.menu-window').hide(); 

    $('#menu').show();
});

$('#message-back').click(function() {
    resetNewMessagesCount()
    currentDisplayedConversationId = null;
    $('.menu-window').hide(); 

    $('#messages-window').show();
});

$('#message-remove').click(showDeleteConfirmationModal);

function startCallTimer(durationElement) {
    let seconds = 0;
    const timer = setInterval(() => {
        seconds++;
        let minutes = Math.floor(seconds / 60);
        let remainingSeconds = seconds % 60;
        let timeString = `${minutes.toString().padStart(2, '0')}:${remainingSeconds.toString().padStart(2, '0')}`;
        durationElement.text(timeString);
    }, 1000);

    return { timerId: timer, elapsedSeconds: () => seconds };
}

function stopCallTimer(timer) {
    clearInterval(timer);
}

let lastPlayedAudioId = null;

function playRandomCallSound() {
    let audioIds = ['callAudio1', 'callAudio2', 'callAudio3'];
    if (lastPlayedAudioId) {
        audioIds = audioIds.filter(id => id !== lastPlayedAudioId);
    }

    let randomIndex = Math.floor(Math.random() * audioIds.length);
    let selectedAudioId = audioIds[randomIndex];
    lastPlayedAudioId = selectedAudioId;

    setTimeout(() => {
        playSound(`#${selectedAudioId}`, 0.1);
    }, 1000);

    return $(`#${selectedAudioId}`)[0];
}

function playSound(soundId, volume = 1) {
    let audioElement = $(soundId)[0];
    audioElement.volume = volume;
    audioElement.currentTime = 0;
    audioElement.play();
}

$('#message-call').click(function() {
    blurDiv('#message-window');
    $('#call-window').fadeIn();
    $('#call-window').css('display', 'flex');

    var conversationId = currentDisplayedConversationId
    var callerId = translate("phone_call_stranger_title", conversationId);
    $('#call-window h2').text(callerId);
    var callDurationElement = $('#call-window p');
    callDurationElement.text('00:00');

    let callTimer = startCallTimer(callDurationElement);
    let callAudio = playRandomCallSound();

    callAudio.onended = function() {
        setTimeout(() => {
            $('#message-call').fadeOut();
            conversations[conversationId].call = false

            stopCallTimer(callTimer.timerId);
            $('#call-window').fadeOut();
            unblurDiv('#message-window');

            let callDuration = callTimer.elapsedSeconds();
            addMessageToConversation(conversationId, translate("phone_call_message_end", callDuration), true);

            var randomDelay = Math.floor(Math.random() * (5500 - 3000 + 1)) + 3000;
            setTimeout(() => {

                quantity = generateRandomQuantity(conversations[conversationId].playerDrugAmount)
                conversations[conversationId].npcTakeAmount = quantity
                $.post('https://sgx-selldrugs/phoneStartTradeMission', JSON.stringify({ item:  conversations[conversationId].itemName, quantity: quantity, price: conversations[conversationId].price }) )
                    .done(function(coords) {
                        if (coords) {
                            addMessageToConversation(conversationId, randomTranslate("phone_message_accept_offer", quantity), false);

                            setTimeout(() => {       
                                conversations[conversationId].gpsCoords = coords
                                addMessageToConversation(conversationId, randomTranslate("phone_message_gps"), false, "img/gps.png");
                            }, 2500);
                        } else if (!coords) {
                            addMessageToConversation(conversationId, randomTranslate("phone_message_no_places"), false);
                        }
                    })

            }, randomDelay);
        }, 2000); 
    };
});

function generateRandomQuantity(playerQuantity) {
    var min = phoneConfig.minQuantity;
    var max = Math.min(playerQuantity, phoneConfig.maxQuantity);

    return Math.floor(Math.random() * (max - min + 1)) + min;
}

var blurActive = false;
function blurDiv(selector) {
    blurActive = true;
    var $div = $(selector);
    var $overlay = $('<div>').addClass('blur-overlay');

    $div.css('position', 'relative').prepend($overlay);

    $div.addClass('blur-effect');
}

function unblurDiv(selector) {
    blurActive = false;
    var $div = $(selector);
    $div.find('.blur-overlay').remove(); 
    $div.removeClass('blur-effect'); 
}

function incrementNewMessagesCount() {
    var $messagesCount = $('#messages-new-amount');
    var count = parseInt($messagesCount.text()) || 0;

    count++;
    $messagesCount.text(count);

    if (count > 0) {
        $messagesCount.css('opacity', 1);
    }
}

function resetNewMessagesCount() {
    var $messagesCount = $('#messages-new-amount');

    $messagesCount.text('0');
    $messagesCount.css('opacity', 0);
}

function updateMessageSmallDataMenu(conversationId, newText) {
    var $messageToUpdate = $('#messages-container').find(`div.message[data-message-id='${conversationId}']`);
    $messageToUpdate.find('.message-data').text(shortenName(newText, 18));
}

var conversations = {};
function createMessageWithJQuery(messageId, itemName) {
    var text = `Got some ${itemName} for sale?`

    if (!conversations[messageId]) {
        conversations[messageId] = {
            itemName: itemName,
            enterHowMuch: true,
            enterPrice: false,
            call: false,
            messages: []
        };
    }

    if (isPhoneVisibleForNotification || !$("#telephone-container").is(":visible") ) {
        showNotification(`Stranger #${messageId}`, text)  
    }

    if (!$("#messages-window").is(":visible")) {
        incrementNewMessagesCount()
    }

    conversations[messageId].messages.push({ fromPlayer: false, text: text });

    var $message = $('<div>', {
        class: 'message',
        'data-message-id': messageId
    });

    var $img = $('<img>', { src: 'img/person.png' });
    $message.append($img);

    var $messageTexts = $('<div>', { class: 'message-texts' });
    var $messageTitle = $('<div>', { class: 'message-title', text: translate("phone_call_stranger_title", messageId) });
    $messageTexts.append($messageTitle);

    var $messageData = $('<div>', { class: 'message-data', text: shortenName(text, 18) });
    $messageTexts.append($messageData);

    $message.append($messageTexts);

    $message.click(function() {
        var clickedMessageId = $(this).data('message-id');
        $('.menu-window').hide(); 
        $('#message-window').show();
        createCorrespondence(clickedMessageId);
    });

    $('#messages-container').prepend($message);
}

function createCorrespondence(conversationId) {
    currentDisplayedConversationId = conversationId;

    var conversation = conversations[conversationId];
    if (!conversation) {
        console.error('The conversation with the given ID does not exist:', conversationId);
        return;
    }

    $('#message-items').empty();

    $('#message-nav p').text(translate("phone_call_stranger_title", conversationId));

    conversation.messages.forEach(function(message, index) {
        var messageClass = message.fromPlayer ? 'message-item message-item-reverse' : 'message-item';

        var $messageItem = $('<div>', { class: messageClass });
        var $img = $('<img>', { src: 'img/person.png' });
        var $text = $('<p>', { text: message.text });

        if (index == conversation.messages.length - 1 && conversation.gps) {
            var $image = $('<img>', { src: 'img/gps.png', class: 'message-image' });
            $text.append($image); 

            $image.click(function() {
                var gpsCoords = conversations[conversationId].gpsCoords;

                $.post('https://sgx-selldrugs/setWaypoint', JSON.stringify({ coords: gpsCoords }))
            });
        }

        $messageItem.append($img).append($text);
        $('#message-items').append($messageItem);
    });


    // INPUT LOAD
    $("#message-input").empty()
    if (conversation.enterHowMuch) {
        var inputField = $("<input>", { 
            type: "number", 
            class: "message-input-field",
            placeholder: translate("phone_message_input_drug_amount"),
            min: "1",
            step: "1"
        });
        var imgAccept = $("<img>", { 
            src: "img/send.png",
            id: "imgAccept",
            click: function() {
                inputAccept('amount', inputField, conversationId, conversation)
            }
        });
        $("#message-input").append(inputField);
        $("#message-input").append(imgAccept);
    } else if (conversation.enterPrice) {
        conversation.enterPrice = true

        var inputField = $("<input>", { 
            type: "number", 
            class: "message-input-field",
            placeholder: translate("phone_message_input_price"),
            min: "1",
            step: "1"
        });

        var imgAccept = $("<img>", { 
            src: "img/send.png",
            id: "imgAccept",
            click: function() {
                inputAccept('price', inputField, conversationId, conversation)
            }
        });

        $("#message-input").append(inputField);
        $("#message-input").append(imgAccept);
    } else {
        var imgAccept = $("<img>", { 
            src: "img/send.png",
            id: "imgAccept",
        });

        $("#message-input").append(imgAccept);
    }

    if (conversation.call) {
        $("#message-call").fadeIn()
    } else if (!conversation.call) {
        $("#message-call").css("display", "none");
    }
}

function inputAccept(type, inputField, conversationId, conversation) {
    var inputValue = inputField.val();
    var numericValue = parseInt(inputValue);
    var valueLimit = phoneConfig.maxQuantity
    var valueMin = phoneConfig.minQuantity

    if (!isNaN(numericValue) && numericValue.toString() === inputValue && numericValue >= 1) {
        if (type == 'amount') {
            $("#imgAccept").off('click');
            inputField.remove();
            conversation.enterHowMuch = false;
            conversation.playerDrugAmount = numericValue
            addMessageToConversation(conversationId, randomTranslate("phone_message_drug_amount", numericValue), true);

            var randomDelay = Math.floor(Math.random() * (5500 - 3000 + 1)) + 3000;
            if (numericValue > valueLimit || numericValue < valueMin) {
                setTimeout(() => {
                    addMessageToConversation(conversationId, randomTranslate("phone_message_drug_amount_fail"), false);
                }, randomDelay);
            } else {
                setTimeout(() => {
                    conversation.enterPrice = true

                    addMessageToConversation(conversationId, randomTranslate('phone_message_price_question'), false);

                    if (currentDisplayedConversationId === conversationId) {
                        $("#message-input").empty()
                        var inputField = $("<input>", { 
                            type: "number", 
                            class: "message-input-field",
                            placeholder: translate("phone_message_input_price"),
                            min: "1",
                            step: "1"
                        });
                        var imgAccept = $("<img>", { 
                            src: "img/send.png",
                            id: "imgAccept",
                            click: function() {
                                inputAccept('price', inputField, conversationId, conversation)
                            }
                        });

                        $("#message-input").append(inputField);
                        $("#message-input").append(imgAccept);
                    }
                }, randomDelay);
            }
        } else if (type == 'price') {
            $("#imgAccept").off('click');
            inputField.remove();
            conversation.enterPrice = false;
            addMessageToConversation(conversationId, randomTranslate("phone_message_price_answer", inputValue), true);

            var inputNumber = parseInt(inputValue)
            var randomDelay = Math.floor(Math.random() * (5500 - 3000 + 1)) + 3000;
            $.post('https://sgx-selldrugs/dialogBack', JSON.stringify({ action: "sell", itemName: conversation.itemName, inputValue: inputNumber, isWholesale: true }))
                .done(function(data) {
                    if (data.result) {
                        setTimeout(() => {
                            conversation.call = true;
                            conversation.price = inputNumber
                            addMessageToConversation(conversationId, randomTranslate("phone_message_call"), false);
        
                            if (currentDisplayedConversationId === conversationId) {
                                $("#message-call").fadeIn(200)
                            }
                        }, randomDelay);
                    } else {
                        setTimeout(() => {
                            addMessageToConversation(conversationId, randomTranslate("phone_message_price_fail"), false);
                        }, randomDelay);
                    }
                })

        }
    } else {
        Notify(translate("notify_input_wrong"), "error", 2500)
    }   
}

function addMessageToConversation(conversationId, text, fromPlayer, imagePath) {
    if (!conversations[conversationId]) {
        console.error('The conversation with the given ID does not exist:', conversationId);
        return;
    }

    var newMessage = { fromPlayer: fromPlayer, text: text };
    conversations[conversationId].messages.push(newMessage);

    var smallMessage = fromPlayer ? translate("notify_input_wrong", text) : text;
    updateMessageSmallDataMenu(conversationId, smallMessage);

    if (currentDisplayedConversationId === conversationId) {
        var messageClass = fromPlayer ? 'message-item message-item-reverse' : 'message-item';
        var $messageItem = $('<div>', { class: messageClass });
        var $img = $('<img>', { src: 'img/person.png' });
        var $text = $('<p>', { text: text });

        if (imagePath) {
            var $image = $('<img>', { src: imagePath, class: 'message-image' });
            $text.append($image); 
            conversations[conversationId].gps = true

            $image.click(function() {
                var gpsCoords = conversations[conversationId].gpsCoords;

                $.post('https://sgx-selldrugs/setWaypoint', JSON.stringify({ coords: gpsCoords }))
            });
        }

        $messageItem.append($img).append($text);
        $('#message-items').append($messageItem);

        scrollInnerElementToBottom("#message-items");

        if (isPhoneVisibleForNotification || !$("#telephone-container").is(":visible") ) {
            if (!fromPlayer) {
                showNotification(translate("phone_call_stranger_title", conversationId), text)  
            }
        }
    } else if (!fromPlayer) {
        showNotification(translate("phone_call_stranger_title", conversationId), text)

        if (!$("#messages-window").is(":visible")) {
            incrementNewMessagesCount()
        }
    }
}

function scrollInnerElementToBottom(selector) {
    var element = $(selector);
    element.animate({
        scrollTop: element.prop('scrollHeight')
    }, 1000);
}

var lastNotificationSwitchTime = 0;
var lastSoundSwitchTime = 0;

function canChangeSwitch(lastChangeTime) {
    var currentTime = Date.now();
    if (currentTime - lastChangeTime < 5000) {
        Notify(translate("notify_settings_error"), "error", 2500)
        return false;
    }
    return true;
}

$('#notificationSwitch').change(function() {
    if (canChangeSwitch(lastNotificationSwitchTime)) {
        lastNotificationSwitchTime = Date.now();

        if (!this.checked) {
            notificationQueue = [];
        }

        var statusAlerts = $(this).prop('checked');
        var statusAlertsSound = $('#soundSwitch').prop('checked');

        $.post('https://sgx-selldrugs/saveSettings', JSON.stringify({ statusAlerts: statusAlerts, statusAlertsSound: statusAlertsSound }));
    } else {
        $(this).prop('checked', !$(this).prop('checked'));
    }
});

$('#soundSwitch').change(function() {
    if (canChangeSwitch(lastSoundSwitchTime)) {
        lastSoundSwitchTime = Date.now();

        var statusAlerts = $('#notificationSwitch').prop('checked');
        var statusAlertsSound = $(this).prop('checked');

        $.post('https://sgx-selldrugs/saveSettings', JSON.stringify({ statusAlerts: statusAlerts, statusAlertsSound: statusAlertsSound }));
    } else {
        $(this).prop('checked', !$(this).prop('checked'));
    }
});


function loadPlayerSettings(settings) {
    if(settings.statusAlerts !== undefined) {
        $('#notificationSwitch').prop('checked', settings.statusAlerts);
    }

    if(settings.statusAlertsSound !== undefined) {
        $('#soundSwitch').prop('checked', settings.statusAlertsSound);
    }
}


var notificationQueue = [];
var isNotificationShowing = false;

function showNotification(title, message) {
    if (!$('#notificationSwitch').is(':checked')) {
        return; 
    }

    notificationQueue.push(function() {
        if (!$("#telephone-container").is(":visible")) {
            togglePhoneForNotification();
        }

        isNotificationShowing = true;
        var $notification = $('<div id="telephone-alert">' +
                              '<div id="alert-title">' +
                              '<img src="img/messages.png">' +
                              '<h2>' + title + '</h2>' +
                              '</div>' +
                              '<p>' + message + '</p>' +
                              '</div>');

        $("#telephone-background").prepend($notification);
        $notification.css('top', '-5.5vh');

        if ($('#soundSwitch').is(':checked')) {
            playSound("#notification", 0.1);
        }

        $notification.animate({ top: '1vh' }, 500, function() {
            setTimeout(function() {
                $notification.animate({ top: '-5.5vh' }, 500, function() {
                    $notification.remove();
                    isNotificationShowing = false;
                    checkQueue();
                });
            }, 3000);
        });
    });

    checkQueue();
}

function checkQueue() {
    if (notificationQueue.length > 0 && !isNotificationShowing) {
        (notificationQueue.shift())();
    } else if (notificationQueue.length === 0 && isPhoneVisibleForNotification) {
        $("#telephone-container").stop().animate({
            bottom: '-60%'
        }, 1000, function() {
            $(this).css('display', 'none');
        });
    }
}

function togglePhoneForNotification() {
    isPhoneVisibleForNotification = true;
    $("#telephone-container").stop().css('display', 'block').animate({
        bottom: '-45%'
    }, 500);
}

function loadPlayerExperiencePhone(data) {
    var respectPercentage = (data.respect / data.respectLimit) * 100;
    $('#app-progress-respect').css('width', respectPercentage + '%');
    $('#app-progress-respect').next('p').text(data.respect + ' / ' + data.respectLimit);

    var salesPercentage = (data.sales / data.salesLimit) * 100;
    $('#app-progress-selling').css('width', salesPercentage + '%');
    $('#app-progress-selling').next('p').text(data.sales + ' / ' + data.salesLimit);
}

// MOLE

var moleConversations = {};
function createConversationMole(moleName, text) {
    if (!moleConversations[moleName]) {
        moleConversations[moleName] = {
            messages: []
        };
    }

    if (isPhoneVisibleForNotification || !$("#telephone-container").is(":visible") ) {
        showNotification(moleName, text)  
    }

    if (!$("#messages-window").is(":visible")) {
        incrementNewMessagesCount()
    }

    moleConversations[moleName].messages.push({ fromPlayer: false, text: text });

    var $message = $('<div>', {
        class: 'message',
        'data-message-id': moleName
    });

    var $img = $('<img>', { src: 'img/person.png' });
    $message.append($img);

    var $messageTexts = $('<div>', { class: 'message-texts' });
    var $messageTitle = $('<div>', { class: 'message-title', text: moleName });
    $messageTexts.append($messageTitle);

    var $messageData = $('<div>', { class: 'message-data', text: shortenName(text, 18) });
    $messageTexts.append($messageData);

    $message.append($messageTexts);

    $message.click(function() {
        var moleNameID = $(this).data('message-id');
        $('.menu-window').hide(); 
        $('#message-window').show();
        createMoleCorrespondence(moleNameID);
    });

    $('#messages-container').prepend($message);
}

function createMoleCorrespondence(moleName) {
    currentDisplayedConversationId = moleName;
    var conversation = moleConversations[moleName];
    if (!conversation) {
        console.error('The conversation with the given ID does not exist:', moleName);
        return;
    }

    $('#message-items').empty();

    $('#message-nav p').text(moleName);

    conversation.messages.forEach(function(message, index) {
        var messageClass = message.fromPlayer ? 'message-item message-item-reverse' : 'message-item';

        var $messageItem = $('<div>', { class: messageClass });
        var $img = $('<img>', { src: 'img/person.png' });
        var $text = $('<p>', { text: message.text });

        $messageItem.append($img).append($text);
        $('#message-items').append($messageItem);
    });


    // INPUT LOAD
    $("#message-input").empty()

    var imgAccept = $("<img>", { 
        src: "img/send.png",
        id: "imgAccept",
    });

    $("#message-input").append(imgAccept);

    $("#message-call").css("display", "none");
}

function addMessageToConversationMole(moleName, text, fromPlayer) {
    if (!moleConversations[moleName]) {
        createConversationMole(moleName, text);
        return;
    }

    var newMessage = { fromPlayer: fromPlayer, text: text };
    moleConversations[moleName].messages.push(newMessage);

    var smallMessage = fromPlayer ? `You: ${text}` : text;
    updateMessageSmallDataMenu(moleName, smallMessage);

    if (currentDisplayedConversationId === moleName) {
        var messageClass = fromPlayer ? 'message-item message-item-reverse' : 'message-item';
        var $messageItem = $('<div>', { class: messageClass });
        var $img = $('<img>', { src: 'img/person.png' });
        var $text = $('<p>', { text: text });

        $messageItem.append($img).append($text);
        $('#message-items').append($messageItem);

        scrollInnerElementToBottom("#message-items");

        if (isPhoneVisibleForNotification || !$("#telephone-container").is(":visible") ) {
            if (!fromPlayer) {
                showNotification(moleName, text)  
            }
        }
    } else if (!fromPlayer) {
        showNotification(moleName, text)

        if (!$("#messages-window").is(":visible")) {
            incrementNewMessagesCount()
        }
    }
}