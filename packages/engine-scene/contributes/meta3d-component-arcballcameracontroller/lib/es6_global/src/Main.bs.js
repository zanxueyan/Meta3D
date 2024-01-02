

import * as ArraySt$Meta3dCommonlib from "../../../../../../../node_modules/meta3d-commonlib/lib/es6_global/src/structure/ArraySt.bs.js";
import * as MutableSparseMap$Meta3dCommonlib from "../../../../../../../node_modules/meta3d-commonlib/lib/es6_global/src/structure/sparse_map/MutableSparseMap.bs.js";
import * as Index$Meta3dComponentArcballcameracontrollerProtocol from "../../../../../../../node_modules/meta3d-component-arcballcameracontroller-protocol/lib/es6_global/src/Index.bs.js";
import * as CreateStateUtils$Meta3dComponentArcballcameracontroller from "./create_state/CreateStateUtils.bs.js";
import * as GetGameObjectsUtils$Meta3dComponentArcballcameracontroller from "./gameobject/GetGameObjectsUtils.bs.js";
import * as AddArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller from "./gameobject/AddArcballCameraControllerUtils.bs.js";
import * as GetArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller from "./gameobject/GetArcballCameraControllerUtils.bs.js";
import * as HasArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller from "./gameobject/HasArcballCameraControllerUtils.bs.js";
import * as CloneArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller from "./operate_component/CloneArcballCameraControllerUtils.bs.js";
import * as CreateArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller from "./operate_component/CreateArcballCameraControllerUtils.bs.js";
import * as RemoveArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller from "./gameobject/RemoveArcballCameraControllerUtils.bs.js";
import * as DisposeArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller from "./operate_component/DisposeArcballCameraControllerUtils.bs.js";
import * as GetAllArcballCameraControllersUtils$Meta3dComponentArcballcameracontroller from "./operate_component/GetAllArcballCameraControllersUtils.bs.js";
import * as GetArcballCameraControllerDataUtils$Meta3dComponentArcballcameracontroller from "./operate_data/GetArcballCameraControllerDataUtils.bs.js";
import * as SetArcballCameraControllerDataUtils$Meta3dComponentArcballcameracontroller from "./operate_data/SetArcballCameraControllerDataUtils.bs.js";
import * as GetNeedDisposedArcballCameraControllersUtils$Meta3dComponentArcballcameracontroller from "./gameobject/GetNeedDisposedArcballCameraControllersUtils.bs.js";

function getContribute(param) {
  return {
          componentName: Index$Meta3dComponentArcballcameracontrollerProtocol.componentName,
          createStateFunc: (function (param) {
              return CreateStateUtils$Meta3dComponentArcballcameracontroller.createState(param.isDebug);
            }),
          getGameObjectsFunc: GetGameObjectsUtils$Meta3dComponentArcballcameracontroller.get,
          createComponentFunc: CreateArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller.create,
          addComponentFunc: AddArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller.add,
          removeComponentFunc: RemoveArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller.remove,
          hasComponentFunc: HasArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller.has,
          getComponentFunc: GetArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller.get,
          getNeedDisposedComponentsFunc: GetNeedDisposedArcballCameraControllersUtils$Meta3dComponentArcballcameracontroller.get,
          getComponentDataFunc: (function (state, cameraController, dataName) {
              return GetArcballCameraControllerDataUtils$Meta3dComponentArcballcameracontroller.getData(state, cameraController, dataName);
            }),
          setComponentDataFunc: (function (state, cameraController, dataName, dataValue) {
              return SetArcballCameraControllerDataUtils$Meta3dComponentArcballcameracontroller.setData(state, cameraController, dataName, dataValue);
            }),
          deferDisposeComponentFunc: DisposeArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller.deferDisposeComponent,
          disposeComponentsFunc: DisposeArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller.disposeComponents,
          cloneComponentFunc: (function (state, countRange, param, sourceArcballCameraController) {
              return CloneArcballCameraControllerUtils$Meta3dComponentArcballcameracontroller.clone(state, countRange, sourceArcballCameraController);
            }),
          getAllComponentsFunc: GetAllArcballCameraControllersUtils$Meta3dComponentArcballcameracontroller.getAll,
          restore: (function (currentState, targetState) {
              return targetState;
            }),
          deepCopy: (function (state) {
              return {
                      config: state.config,
                      maxIndex: state.maxIndex,
                      gameObjectMap: state.gameObjectMap,
                      dirtyMap: MutableSparseMap$Meta3dCommonlib.copy(state.dirtyMap),
                      distanceMap: MutableSparseMap$Meta3dCommonlib.copy(state.distanceMap),
                      minDistanceMap: MutableSparseMap$Meta3dCommonlib.copy(state.minDistanceMap),
                      phiMap: MutableSparseMap$Meta3dCommonlib.copy(state.phiMap),
                      thetaMap: MutableSparseMap$Meta3dCommonlib.copy(state.thetaMap),
                      thetaMarginMap: MutableSparseMap$Meta3dCommonlib.copy(state.thetaMarginMap),
                      targetMap: MutableSparseMap$Meta3dCommonlib.copy(state.targetMap),
                      moveSpeedXMap: MutableSparseMap$Meta3dCommonlib.copy(state.moveSpeedXMap),
                      moveSpeedYMap: MutableSparseMap$Meta3dCommonlib.copy(state.moveSpeedYMap),
                      rotateSpeedMap: MutableSparseMap$Meta3dCommonlib.copy(state.rotateSpeedMap),
                      wheelSpeedMap: MutableSparseMap$Meta3dCommonlib.copy(state.wheelSpeedMap),
                      gameObjectArcballCameraControllerMap: MutableSparseMap$Meta3dCommonlib.copy(state.gameObjectArcballCameraControllerMap),
                      needDisposedArcballCameraControllers: ArraySt$Meta3dCommonlib.copy(state.needDisposedArcballCameraControllers),
                      disposedArcballCameraControllers: ArraySt$Meta3dCommonlib.copy(state.disposedArcballCameraControllers),
                      names: state.names
                    };
            })
        };
}

export {
  getContribute ,
}
/* No side effect */
