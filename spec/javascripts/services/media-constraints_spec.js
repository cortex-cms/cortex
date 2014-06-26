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
      expect(service.aspectratio(media, [1.2, 1.3])).toBeTruthy();
      expect(service.aspectratio(media, 1.7)).toBeFalsy();
      expect(service.aspectratio(media, [1.7])).toBeFalsy();
    });

    it("should check total size", function() {
      expect(service.totalSize(media, 480000,.9)).toBeTruthy();
      expect(service.totalSize(media, 48000000,.9)).toBeFalsy();
    });

    describe("featuredMediaConstraintsService", function() {
      var failMedia;
      beforeEach(inject(function($injector) {
        failMedia = {
          dimensions: [1, 1]
        };
        media = {
          dimensions: [1920, 1080]
        };
        service = $injector.get("featuredMediaConstraintsService");
      }));

      it("should check width constraints", function() {
        expect(service.width(media)).toBeTruthy();
        expect(service.width(failMedia)).toBeFalsy();
      });

      it("should check aspect ratio constraints", function() {
        expect(service.aspectratio(media)).toBeTruthy();
        expect(service.aspectratio(failMedia)).toBeFalsy();
      });

      it("should check total size", function() {
        expect(service.totalSize(media)).toBeTruthy();
        expect(service.totalSize(failMedia)).toBeFalsy();
      });
    });

    describe("tileMediaConstraintsService", function() {
      var failMedia;
      beforeEach(inject(function($injector) {
        failMedia = {
          dimensions: [1, 5]
        };
        media = {
          dimensions: [400, 400]
        };
        service = $injector.get("tileMediaConstraintsService");
      }));

      it("should check width constraints", function() {
        expect(service.width(media)).toBeTruthy();
        expect(service.width(failMedia)).toBeFalsy();
      });

      it("should check aspect ratio constraints", function() {
        expect(service.aspectratio(media)).toBeTruthy();
        expect(service.aspectratio(failMedia)).toBeFalsy();
      });


    });
  });

})();