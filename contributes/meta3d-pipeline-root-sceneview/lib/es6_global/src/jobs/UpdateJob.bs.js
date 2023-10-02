

import * as Curry from "../../../../../../node_modules/rescript/lib/es6/curry.js";
import * as Utils$Meta3dPipelineRootSceneview from "./Utils.bs.js";

function execFunc(meta3dState, param) {
  var match = Utils$Meta3dPipelineRootSceneview.getState(Curry._1(param.getStatesFunc, meta3dState));
  return Curry._1(match.mostService.callFunc, (function (param) {
                console.log("update root job exec");
                return meta3dState;
              }));
}

export {
  execFunc ,
}
/* Utils-Meta3dPipelineRootSceneview Not a pure module */
