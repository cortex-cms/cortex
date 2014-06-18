angular.module('cortex.services.mediaConstraints', [])

.factory('mediaConstraintsService', function($rootScope) {
	var filesize = function(media, max) {
		return media.attachment_file_size <= max;
	};

	var width = function(media, min, max) {
		console.log(media.dimensions[0] >= min && media.dimensions[0] <= max);
		return media.dimensions[0] >= min && (media.dimensions[0] <= max || max === -1);
	};

	var height = function(media, min, max) {
		return media.dimensions[1] >= min && (media.dimensions[1] <= max || max === -1);
	};

	var aspectratio = function(media, valid) {
		var gcf = _gcd(media.dimensions[0], media.dimensions[1]);
		var aspectRatio = media.dimensions[0] / gcf + ":" + media.dimensions[1] / gcf;
		if (angular.isString(valid)) {
			return aspectRatio === valid;
		}
		else if (angular.isArray(valid)) {
			return valid.indexOf(aspectRatio) >= 0 ? true : false;
		}
	};

	var _gcd = function(a, b) {
		if ( ! b) {
			return a;
		}
		return _gcd(b, a % b);
	};

	return {
		filesize: filesize,
		width: width,
		height: height,
		aspectratio: aspectratio,
		_gcd: _gcd
	};

});