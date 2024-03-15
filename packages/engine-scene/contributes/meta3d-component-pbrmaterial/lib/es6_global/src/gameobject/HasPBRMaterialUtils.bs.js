

import * as MutableSparseMap$Meta3dCommonlib from "../../../../../../../../node_modules/meta3d-commonlib/lib/es6_global/src/structure/sparse_map/MutableSparseMap.bs.js";

function has(param) {
  var gameObjectPBRMaterialMap = param.gameObjectPBRMaterialMap;
  return function (gameObject) {
    return MutableSparseMap$Meta3dCommonlib.has(gameObjectPBRMaterialMap, gameObject);
  };
}

export {
  has ,
}
/* No side effect */
