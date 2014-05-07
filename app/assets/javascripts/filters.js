var module = angular.module('cortex.filters', []);

// Turns underscores into spaces, capitalizes first letter of string
module.filter('humanize', function() {
  return function(string) {
    string = string.split('_').join(' ').toLowerCase();
    return string.charAt(0).toUpperCase() + string.slice(1);
  };
});

// Turns Media into its HTML representation
module.filter('mediaToHtml', function() {
  return function(media) {
    var outputHtml;

    if (media.general_type ==='image') {
      outputHtml = '<p><a href="' +
        media.attachment_url +
        '"><img alt="' +
        (media.alt || '') +
        '" src="' +
        media.attachment_url +
        '" data-media-id="' +
        media.id +
        '"></a></p>';
    }
    else {
      outputHtml = '<a href=""' +
        media.attachment_url +
        '" data-media-id="' +
        media.id +
        '">' +
        media.name +
        '</a>';
    }

    return outputHtml;
  };
});

module.filter('tagList', function() {
    return function(tags) {
        return _.map(tags, function(t) { return t.name; }).join(', ');
    };
});

module.filter('publishStatus', function() {
    return function(dateStr) {
        var date = Date.parse(dateStr);
        return date < new Date() ? 'Scheduled' : 'Published';
    };
});

// https://gist.github.com/thomseddon/3511330
module.filter('bytes', function(){
    return function(bytes, precision) {

        if (isNaN(parseFloat(bytes)) || !isFinite(bytes)) {
            return '-';
        }

        if (typeof precision === 'undefined') {
            precision = 1;
        }

        var units = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB'],
            number = Math.floor(Math.log(bytes) / Math.log(1024));

        return (bytes / Math.pow(1024, Math.floor(number))).toFixed(precision) +  ' ' + units[number];
    };
});
