import { getContribute as getContributeMeta3D } from "meta3d-type"
import { actionContribute } from "meta3d-event-protocol/src/contribute/ActionContributeType"
import { actionData } from "meta3d-action-click-button-test1-protocol"
import { dependentExtensionProtocolNameMap, dependentContributeProtocolNameMap } from "meta3d-action-click-button-test1-protocol/src/DependentMapType"
import { service as test2Service } from "meta3d-extension-test2-protocol/src/service/ServiceType"
// import { state as test2State } from "meta3d-extension-test2-protocol/src/state/StateType"

export let getContribute: getContributeMeta3D<dependentExtensionProtocolNameMap, dependentContributeProtocolNameMap, actionContribute<actionData>> = (api, [dependentExtensionProtocolNameMap, _]) => {
    let { meta3dTest2ExtensionProtocolName } = dependentExtensionProtocolNameMap
    return {
        actionName: "ClickButtonTest1",
        handler: (meta3dState, actionData) => {
            console.log("click button test1")

            let { invokeExtensionTest1 } = api.getExtensionService<test2Service>(meta3dState, meta3dTest2ExtensionProtocolName)

            invokeExtensionTest1(meta3dState)

            return new Promise((resolve) => {
                resolve(meta3dState)
            })
        }
    }
}
