(function () {
  'use strict';

  describe("Media-Constraints service", function() {
    var media, service;
    beforeEach(module("cortex.services.mediaConstraints"));

    beforeEach(inject(function($injector) {
      media = {
        dimensions: [800, 600]
      };
      service = $injector.get("mediaConstraintsService");
    }));

    it("should check width constraints", function() {
      expect(service.width(media, 500, 1000)).toBeTruthy();
      expect(service.width(media, 500, -1)).toBeTruthy();
      expect(service.width(media, 1000, 1100)).toBeFalsy();
      expect(service.width(media, 1000, -1)).toBeFalsy();
    });

    it("should check height constraints", function() {
      expect(service.height(media, 500, 1000)).toBeTruthy();
      expect(service.height(media, 500, -1)).toBeTruthy();
      expect(service.height(media, 1000, 1100)).toBeFalsy();
      expect(service.height(media, 1000, -1)).toBeFalsy();
    });

    it("should check aspect ratio constraints", function() {
      expect(service.aspectratio(media, 1.3)).toBeTruthy();
      expect(service.aspectratio(media, [1.3])).toBeTruthy();
      expect(service.aspectratio(media, 1.7)).toBeFalsy();
      expect(service.aspectratio(media, [1.7])).toBeFalsy();
    });

    it("should check total size", function() {
      expect(service.totalSize(media, 480000,.9)).toBeTruthy();
      expect(service.totalSize(media, 48000000,.9)).toBeFalsy();
    });

    xdescribe("featuredMediaConstraintsService", function() {

    });

    xdescribe("tileMediaConstraintsService", function() {

    });
  });

})();