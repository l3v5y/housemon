module.exports = (ng) ->

  ng.controller 'LEDCtrl', [
    '$scope',
    ($scope) ->

      $scope.led = $scope.readings.find 'led'

      $scope.$on 'set.readings.led', (event, obj, oldObj) ->
        $scope.led = obj

      # trigger only on changes in l1 or l2
      #$scope.$watch 'led.r + led.g + led.b', ->
        
      $scope.sendLedData = () ->
        $scope.readings.store $scope.led
  ]
