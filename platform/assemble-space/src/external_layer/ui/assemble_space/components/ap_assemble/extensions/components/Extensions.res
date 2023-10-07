open FrontendUtils.Antd
%%raw("import 'antd/dist/antd.css'")
open FrontendUtils.AssembleSpaceType

module Method = {
  let selectExtension = (
    dispatch,
    protocolIconBase64,
    // TODO remove
    protocolDisplayName,
    protocolRepoLink,
    protocolDescription,
    protocolConfigStr,
    extension,
  ) => {
    dispatch(
      FrontendUtils.ApAssembleStoreType.SelectExtension(
        protocolIconBase64,
        protocolConfigStr,
        extension,
      ),
    )
  }

  let useSelector = ({selectedExtensions}: FrontendUtils.ApAssembleStoreType.state) => {
    selectedExtensions
  }
}

@react.component
let make = (~service: service, ~selectedExtensionsFromMarket: selectedExtensionsFromMarket) => {
  <ExtensionsUtils
    service
    selectedExtensionsFromMarket
    selectedExtensionNames={FrontendUtils.ReduxUtils.ApAssemble.useSelector(
      service.react.useSelector,
      Method.useSelector,
    )->Meta3dCommonlib.ListSt.map(({data}) => data.extensionPackageData.name)}
    useDispatch=FrontendUtils.ReduxUtils.ApAssemble.useDispatch
    selectExtension=Method.selectExtension
  />
}
