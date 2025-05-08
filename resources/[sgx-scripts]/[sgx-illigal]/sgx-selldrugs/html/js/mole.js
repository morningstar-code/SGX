function generateAndDisplaySubscriptions(data) {
    $('#app-subcriptions').empty();

    var imgMap = {
        'criminal': 'img/worker.png',
        'junkie': 'img/homeless.png',
        'professional': 'img/businessman.png'
    };

    var $container = $('#app-subcriptions');

    for (var category in data) {
        var categoryData = data[category];
        for (var name in categoryData) {
            var entry = categoryData[name];
            var imgSrc = imgMap[category] || 'img/default.png';

            var subscriptionHtml = '<div class="subscription">' +
                                       '<img src="' + imgSrc + '">' +
                                       '<div class="subscription-texts">' +
                                           '<h2 class="subscription-name">' + name + '</h2>' +
                                           '<p class="subscription-date">Ends ' + entry.date + '</p>' +
                                       '</div>' +
                                   '</div>';

            $container.append(subscriptionHtml);
        }
    }
}
