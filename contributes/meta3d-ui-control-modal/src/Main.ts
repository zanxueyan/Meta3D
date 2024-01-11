import { getContribute as getContributeMeta3D } from "meta3d-type"
import { uiControlName, state as uiControlState, inputFunc, specificData, outputData } from "meta3d-ui-control-modal-protocol"
import { service, uiControlContribute } from "meta3d-editor-whole-protocol/src/service/ServiceType"

export let getContribute: getContributeMeta3D<uiControlContribute<inputFunc, specificData, outputData>> = (api) => {
    return {
        uiControlName: uiControlName,
        func: (meta3dState,
            _,
            rect,
            {
                label,
                childrenFunc
            }
        ) => {
            let { beginModal, endModal } = api.nullable.getExn(api.getPackageService<service>(meta3dState, "meta3d-editor-whole-protocol")).ui(meta3dState)

            let data = beginModal(meta3dState, label)
            meta3dState = data[0]
            let isOpen_ = data[1]

            if (isOpen_) {
                return childrenFunc(meta3dState).then(meta3dState => {
                    meta3dState = endModal(meta3dState)

                    return [meta3dState, null]
                })
            }

            return Promise.resolve([meta3dState, null])
        },
        init: (meta3dState) => Promise.resolve(meta3dState)
    }
}
