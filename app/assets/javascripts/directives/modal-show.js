angular.module('cortex.directives.modalShow', [])

.directive("modalShow", function () {
    return {
        restrict: "A",
        scope: {
            modalVisible: "="
        },
        link: function (scope, element, attrs) {
            scope.showModal = function (visible) {
                if (visible) {
                    element.modal("show");
                }
                else {
                    element.modal("hide");
                }
            };

            if (!attrs.modalVisible) {
                scope.showModal(true);
            }
            else {
                scope.$watch("modalVisible", function (newValue, oldValue) {
                    scope.showModal(newValue);
                });

                element.bind("hide.bs.modal", function () {
                    scope.modalVisible = false;
                    if (!scope.$$phase && !scope.$root.$$phase) {
                        scope.$apply();
                    }
                });
            }
        }
    };
});
