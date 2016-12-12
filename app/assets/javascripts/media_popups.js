//helper functions for DOM traversal and converting NodeList to iterable Array
if (!window.DOM_HELPER) {
  window.DOM_HELPER = {};
  window.DOM_HELPER.getAll = function(selector, node) {
    var domNode = node ? node : document;
    var domElemList = domNode.querySelectorAll(selector);
    if (!domElemList.length) {
      console.log("could not find elements with selector: " + selector);
      return false;
    }
    var jsArray = [];
    for (var i = 0; i < domElemList.length; i++) {
      jsArray.push(domElemList[i]);
    }
    return jsArray;
  };
};

window.setModals = function() {

  var modals = DOM_HELPER.getAll('.mdl-dialog').reduce(function(modalHolder, modal, i) {
    if (!modal.showModal) {
      dialogPolyfill.registerDialog(modal);
    }

    modalHolder[modal.dataset.type] = {
      elem: modal,
      isOpen: false,
      open: function() {
        modal.showModal();
        this.isOpen = true;
      },
      close: function() {
        if (!this.isOpen) {
          return;
        }
        modal.close();
        this.isOpen = false;
      }
    }
    modal.querySelector('.close').onclick = function() {
      modalHolder[modal.dataset.type].close();
    }
    return modalHolder;
  }, {});
  window.MODALS = modals;
}
