// helper functions for DOM traversal and converting NodeList to iterable Array
if (!window.DOM_HELPER) {
  window.DOM_HELPER = {};
  window.DOM_HELPER.getAll = function (selector, node) {
    var domNode = node ? node : document;
    var domElemList = domNode.querySelectorAll(selector);
    var jsArray = [];
    for (var i = 0; i < domElemList.length; i++) {
      jsArray.push(domElemList[i]);
    }

    return jsArray;
  }
}

window.setModals = function () {
  var modals = window.DOM_HELPER.getAll('.dialog-backdrop').reduce(function (modalHolder, modal, i) {
    modalHolder[modal.dataset.type] = {
      elem: modal,
      isOpen: false,
      open: function () {
        modal.classList.remove('hidden');
        this.isOpen = true;
      },
      close: function () {
        if (!this.isOpen) {
          return
        }
        modal.classList.add('hidden');
        this.isOpen = false;
      }
    };

    modal.querySelector('.close').onclick = function () {
      modalHolder[modal.dataset.type].close();
    };
    return modalHolder
  }, {});

  window.MODALS = modals
};

window.onload = function () {
  window.setModals();
};

$(".popup--open").on("click", function (ev) {
  ev.preventDefault();
  window.MODALS.featured.open();
});

$(".media-select--wysiwyg").on("click", function (ev) {
  ev.preventDefault();

  var element = $(this),
    id = element.data().id,
    title = element.data().title,
    url = element.data().url,
    alt = element.data().alt,
    asset_type = element.data().assetType;

  media_select_defer.resolve({id: id, title: title, url: url, alt: alt, asset_type: asset_type});
});
