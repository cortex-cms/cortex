angular.module('cortex.services.mediaConstraints', [])

.factory('mediaConstraintsService', function($rootScope) {
	var filesize = function(media, max) {
		return media.attachment_file_size <= max;
	};

	var width = function(media, min, max) {
		return media.dimensions[0] >= min && (media.dimensions[0] <= max || max === -1);
	};

	var height = function(media, min, max) {
		return media.dimensions[1] >= min && (media.dimensions[1] <= max || max === -1);
	};

	var aspectratio = function(media, valid) {
		var aspectRatio = media.dimensions[0] / media.dimensions[1];
		if (angular.isNumber(valid)) {
			return aspectRatio.toFixed(1) === valid.toFixed(1);
		}
		else if (angular.isArray(valid)) {
			return valid.filter(function(x) { 
				return compareDecimal(x, aspectRatio) 
			}).length;
		}
	};

	function compareDecimal(x, y) {
		return x.toFixed(1) === y.toFixed(1);
	}

	var totalSize = function(media, valid, decimal) {
		return decimal * valid <= media.dimensions[0] * media.dimensions[1];
	};

	return {
		filesize: filesize,
		width: width,
		height: height,
		aspectratio: aspectratio,
		totalSize: totalSize
	};

})

.factory('featuredMediaConstraintsService', function($rootScope, mediaConstraintsService) {
	var parent = mediaConstraintsService;
	var child = angular.copy(parent);
	child.width = function(media) {
		return parent.width(media, 1100, -1);
	};
	child.totalSize = function(media) {
		return parent.totalSize(media, 660000, .9);
	};

	child.aspectratio = function(media) {
		return parent.aspectratio(media, [1.6, 1.7, 1.8]);
	};

	return child;

})

.factory('tileMediaConstraintsService', function($rootScope, mediaConstraintsService) {
	var parent = mediaConstraintsService;
	var child = angular.copy(parent);

	child.width = function(media) {
		return parent.width(media, 375, -1);
	};

	child.aspectratio = function(media) {
		return parent.aspectratio(media, [1.0, 1.1, 1.2]);
	};

	return child;
});