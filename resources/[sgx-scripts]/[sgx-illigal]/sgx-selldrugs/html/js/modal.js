function showModal(title, content) {
    $('#modal h2').text(title);
    $('#modal p').text(content);

    $('#modal').fadeIn();

    $('#modal-button-accept').off('click').on('click', function() {
        handleUserChoice(true);
    });

    $('#modal-button-cancel').off('click').on('click', function() {
        handleUserChoice(false);
    });
}

function handleUserChoice(choice) {
    $('#modal').fadeOut();
    $.post('https://sgx-selldrugs/modalChoice', JSON.stringify(choice));
}

function showDeleteConfirmationModal() {
    blurDiv('#message-window');

    showModal('Confirm Deletion', 'Are you sure you want to delete this conversation?');

    $('#modal-button-accept').off('click').on('click', function() {
        if (currentDisplayedConversationId !== undefined) {
            $.post('https://sgx-selldrugs/playerDeletedConversation', JSON.stringify(currentDisplayedConversationId));

            $(`[data-message-id="${currentDisplayedConversationId}"]`).remove();
            delete conversations[currentDisplayedConversationId];
            currentDisplayedConversationId = undefined;
        }
        
        unblurDiv('#message-window');

        $('#messages-window').show();
        $('.message-window').hide(); 
        $('#modal').fadeOut();
    });

    $('#modal-button-cancel').off('click').on('click', function() {
        unblurDiv('#message-window');

        $('#modal').fadeOut();
    });
}