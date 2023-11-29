let serializeLib = protocolConfigStr => {
  LibUtils.serializeLib(protocolConfigStr, "UIControlProtocolConfig")
}

let getUIControlSpecificDataFields = configLib => {
  (LibUtils.getFuncFromLib(configLib, "getUIControlSpecificDataFields")->Obj.magic)()
}

let hasChildren = configLib => {
  (LibUtils.getFuncFromLib(configLib, "hasChildren")->Obj.magic)(.)
}

let getUIControlSupportedEventNames = configLib => {
  (LibUtils.getFuncFromLib(configLib, "getUIControlSupportedEventNames")->Obj.magic)(.)
}

let generateHandleUIControlEventStr = (configLib, actionNames) => {
  (LibUtils.getFuncFromLib(configLib, "generateHandleUIControlEventStr")->Obj.magic)(. actionNames)
}
