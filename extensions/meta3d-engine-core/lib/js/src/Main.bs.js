'use strict';

var Curry = require("rescript/lib/js/curry.js");
var DirectorForJs$Meta3dEngineCore = require("./manager/DirectorForJs.bs.js");

function getService(api, param) {
  var meta3dBsMostExtensionName = param.meta3dBsMostExtensionName;
  return {
          func1: (function (state) {
              var match = Curry._2(api.getServiceExn, state, meta3dBsMostExtensionName);
              return Curry._1(match.just, 1);
            })
        };
}

var prepare = DirectorForJs$Meta3dEngineCore.prepare;

var init = DirectorForJs$Meta3dEngineCore.init;

var runPipeline = DirectorForJs$Meta3dEngineCore.runPipeline;

var registerWorkPlugin = DirectorForJs$Meta3dEngineCore.registerWorkPlugin;

var unregisterWorkPlugin = DirectorForJs$Meta3dEngineCore.unregisterWorkPlugin;

var getIsDebug = DirectorForJs$Meta3dEngineCore.getIsDebug;

var setIsDebug = DirectorForJs$Meta3dEngineCore.setIsDebug;

var registerComponent = DirectorForJs$Meta3dEngineCore.registerComponent;

var unregisterComponent = DirectorForJs$Meta3dEngineCore.unregisterComponent;

var createAndSetComponentState = DirectorForJs$Meta3dEngineCore.createAndSetComponentState;

var createComponent = DirectorForJs$Meta3dEngineCore.createComponent;

var unsafeGetRelatedComponentData = DirectorForJs$Meta3dEngineCore.unsafeGetRelatedComponentData;

var setRelatedComponentData = DirectorForJs$Meta3dEngineCore.setRelatedComponentData;

var setComponentData = DirectorForJs$Meta3dEngineCore.setComponentData;

var addComponent = DirectorForJs$Meta3dEngineCore.addComponent;

var hasComponent = DirectorForJs$Meta3dEngineCore.hasComponent;

var getComponent = DirectorForJs$Meta3dEngineCore.getComponent;

var getAllComponents = DirectorForJs$Meta3dEngineCore.getAllComponents;

var getComponentData = DirectorForJs$Meta3dEngineCore.getComponentData;

var getComponentGameObjects = DirectorForJs$Meta3dEngineCore.getComponentGameObjects;

var setGameObjectData = DirectorForJs$Meta3dEngineCore.setGameObjectData;

var createAndSetGameObjectState = DirectorForJs$Meta3dEngineCore.createAndSetGameObjectState;

var createGameObject = DirectorForJs$Meta3dEngineCore.createGameObject;

var getAllGameObjects = DirectorForJs$Meta3dEngineCore.getAllGameObjects;

var getState = DirectorForJs$Meta3dEngineCore.getState;

exports.prepare = prepare;
exports.init = init;
exports.runPipeline = runPipeline;
exports.registerWorkPlugin = registerWorkPlugin;
exports.unregisterWorkPlugin = unregisterWorkPlugin;
exports.getIsDebug = getIsDebug;
exports.setIsDebug = setIsDebug;
exports.registerComponent = registerComponent;
exports.unregisterComponent = unregisterComponent;
exports.createAndSetComponentState = createAndSetComponentState;
exports.createComponent = createComponent;
exports.unsafeGetRelatedComponentData = unsafeGetRelatedComponentData;
exports.setRelatedComponentData = setRelatedComponentData;
exports.setComponentData = setComponentData;
exports.addComponent = addComponent;
exports.hasComponent = hasComponent;
exports.getComponent = getComponent;
exports.getAllComponents = getAllComponents;
exports.getComponentData = getComponentData;
exports.getComponentGameObjects = getComponentGameObjects;
exports.setGameObjectData = setGameObjectData;
exports.createAndSetGameObjectState = createAndSetGameObjectState;
exports.createGameObject = createGameObject;
exports.getAllGameObjects = getAllGameObjects;
exports.getState = getState;
exports.getService = getService;
/* No side effect */
