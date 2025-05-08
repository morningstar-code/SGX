function Notify(text, type, duration) {
    $.post('https://sgx-selldrugs/notification', JSON.stringify({ text: text, type: type, duration: duration }));
}