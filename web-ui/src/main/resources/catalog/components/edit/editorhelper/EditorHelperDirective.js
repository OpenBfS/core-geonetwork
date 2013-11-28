(function() {
  goog.provide('gn_editor_helper_directive');

  var module = angular.module('gn_editor_helper_directive', []);

  /**
     *  Create a widget to handle a list of suggestion to help editor
     *  to populate a field.
     *
     */
  module.directive('gnEditorHelper', [
    function() {

      return {
        restrict: 'A',
        replace: false,
        transclude: false,
        scope: {
          mode: '@gnEditorHelper',
          ref: '@',
          type: '@',
          relatedElement: '@',
          relatedAttr: '@'
        },
        templateUrl: '../../catalog/components/edit/editorhelper/partials/' +
            'editorhelper.html',
        link: function(scope, element, attrs) {
          var field = document.gnEditor[scope.ref],
              relatedAttributeField = document.gnEditor[scope.relatedAttribute],
              relatedElementField = document.gnEditor[scope.relatedElement],
              initialValue = field.value;

          // Function to properly set the target field value
          var populateField = function(field, value) {
            if (field && value !== undefined) {
              field.value = field.type === 'number' ? parseFloat(value) : value;
            }
          };


          // Load the config from the textarea containing the helpers
          scope.config =
              angular.fromJson($('#' + scope.ref + '_config')[0].value);

          // Check if current value is one of the suggestion
          var isInList = false;
          angular.forEach(scope.config.option, function (opt) {
            if (opt['@value'] === initialValue) {
              isInList = true;
            }
          });
          if (!isInList) {
            scope.otherValue = {'@value' : initialValue};
          } else {
            scope.otherValue = {'@value' : ''};
          }

          // Set the initial value
          scope.config.selected = {};
          scope.config.value =
              field.type === 'number' ? parseFloat(field.value) : field.value;
          scope.config.layout =
              scope.mode && scope.mode.indexOf('radio') !== -1 ?
              'radio' : scope.mode;

          scope.selectOther = function() {
            $('#otherValue_' + scope.ref).focus();
          }
          scope.selectOtherRadio = function() {
            $('#otherValueRadio_' + scope.ref).prop("checked", true);
          }
          scope.updateWithOtherValue = function() {
            field.value = scope.otherValue['@value'];
          }

          // On change event update the related element(s)
          // which is sent by the form
          scope.$watch('config.selected', function() {
            var option = scope.config.selected;
            if (option && option['@value']) {
              // Set the current value to the selected option if not empty
              scope.config.value =
                  field.type === 'number' ?
                  parseFloat(option['@value']) : option['@value'];
              populateField(relatedAttributeField, option['@title'] || '');
              populateField(relatedElementField, option['@title'] || '');
            }
          });

          // When field value change, update the main element
          // value
          scope.$watch('config.value', function() {
            populateField(field, scope.config.value);
          });
        }
      };
    }]);
})();
