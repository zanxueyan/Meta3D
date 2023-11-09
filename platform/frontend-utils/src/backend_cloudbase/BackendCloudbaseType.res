type account = string

type versionRange = string

type version = string

type implementName = string

type implementDisplayName = string

type implementVersion = version

type repoLink = string

type description = string

type limitCount = int

type skipCount = int

type count = int

type protocolName = string

type protocolDisplayName = string

type protocolVersion = version

type protocolIconBase64 = string

type protocolRepoLink = repoLink

type protocolDescription = description

// TODO refactor: move type out
type protocol = {
  name: protocolName,
  version: protocolVersion,
  account: account,
  iconBase64: protocolIconBase64,
  displayName: protocolDisplayName,
  // repoLink: option<repoLink>,
  repoLink: repoLink,
  description: description,
}

type protocols = array<protocol>

type init = string => Meta3dBsMost.Most.stream<unit>

type handleLoginForWeb3 = account => Meta3dBsMost.Most.stream<unit>

type checkUserName = string => Meta3dBsMost.Most.stream<bool>

type registerUser = string => Meta3dBsMost.Most.stream<unit>

type isLoginSuccess = string => Meta3dBsMost.Most.stream<(
  bool,
  Js.Nullable.t<string>,
)>

type getAllPublishExtensionProtocols = (
  . limitCount,
  skipCount,
) => Meta3dBsMost.Most.stream<protocols>

type getAllPublishExtensionProtocolsCount = unit => Meta3dBsMost.Most.stream<count>

type getAllPublishContributeProtocols = getAllPublishExtensionProtocols

type batchFindPublishExtensionProtocols = (
  . // . array<(protocolName, protocolVersion)>,
  array<
    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,
    protocolName,
  >,
) => Meta3dBsMost.Most.stream<protocols>

type batchFindPublishContributeProtocols = (
  . // . array<(protocolName, protocolVersion)>,
  array<
    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,
    protocolName,
  >,
) => Meta3dBsMost.Most.stream<protocols>

// type protocolConfig = {
//   name: string,
//   version: string,
//   account: string,
//   configStr: string,
// }

type protocolConfigs = array<CommonType.protocolConfig>

type getAllPublishExtensionProtocolConfigs = (
  limitCount,
  skipCount,
) => Meta3dBsMost.Most.stream<protocolConfigs>

type getAllPublishContributeProtocolConfigs = getAllPublishExtensionProtocolConfigs

type batchFindPublishExtensionProtocolConfigs = (
  . // . array<(protocolName, protocolVersion)>,
  array<
    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,
    protocolName,
  >,
) => Meta3dBsMost.Most.stream<protocolConfigs>

type batchFindPublishContributeProtocolConfigs = (
  . // . array<(protocolName, protocolVersion)>,
  array<
    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,

    // . array<(protocolName, protocolVersion)>,
    protocolName,
  >,
) => Meta3dBsMost.Most.stream<protocolConfigs>

type implementInfo = {
  id: string,
  name: implementName,
  version: implementVersion,
  account: account,
  displayName: implementDisplayName,
  // repoLink: option<repoLink>,
  repoLink: repoLink,
  description: description,
}

type implementInfos = array<implementInfo>

type onUploadProgressFunc = int => unit

type getAllPublishExtensionInfos = (
  . limitCount,
  skipCount,
  protocolName,
  protocolVersion,
) => Meta3dBsMost.Most.stream<implementInfos>

type getAllPublishContributeInfos = getAllPublishExtensionInfos

type onDownloadProgressFunc = int => unit

type findPublishExtension = (
  . onDownloadProgressFunc,
  limitCount,
  skipCount,
  account,
  implementName,
  implementVersion,
) => Meta3dBsMost.Most.stream<Js.Nullable.t<Js.Typed_array.ArrayBuffer.t>>

type findPublishContribute = findPublishExtension

// type loadExtension = (. Js.Typed_array.ArrayBuffer.t) => Meta3d.ExtensionFileType.extensionFileData

// type loadContribute = (
//   . Js.Typed_array.ArrayBuffer.t,
// ) => Meta3d.ExtensionFileType.contributeFileData

type appName = string

type publishAppInfo = {
  account: account,
  appName: appName,
  description: description,
}

type publishApp = (
  . onUploadProgressFunc,
  Js.Typed_array.ArrayBuffer.t,
  appName,
  account,
  description,
) => Meta3dBsMost.Most.stream<unit>

type findPublishApp = (
  . onDownloadProgressFunc,
  account,
  appName,
) => Meta3dBsMost.Most.stream<Js.Nullable.t<Js.Typed_array.ArrayBuffer.t>>

type findAllPublishApps = (
  . limitCount,
  skipCount,
) => Meta3dBsMost.Most.stream<array<publishAppInfo>>

type publishElementContribute = (
  . onUploadProgressFunc,
  account,
  (string, string, string, string, string, string, string),
  Js.Typed_array.ArrayBuffer.t,
) => Meta3dBsMost.Most.stream<unit>

type rec uiControl = {
  displayName: string,
  rect: ElementAssembleStoreType.rect,
  isDraw: ElementAssembleStoreType.isDraw,
  event: ElementAssembleStoreType.event,
  specific: ElementAssembleStoreType.specific,
  children: array<uiControl>,
}

type inspectorData = {
  // element: ElementAssembleStoreType.elementInspectorData,
  uiControls: array<uiControl>,
}

type elementName = string

type elementVersion = implementVersion

type publishElementAssembleData = (
  . account,
  elementName,
  elementVersion,
  inspectorData,
) => Meta3dBsMost.Most.stream<unit>

type implement = {
  id: string,
  file: Js.Typed_array.ArrayBuffer.t,
  version: implementVersion,
  account: account,
}

type implements = array<implement>

type getAllPublishNewestExtensions = (
  . limitCount,
  skipCount,
  protocolName,
) => Meta3dBsMost.Most.stream<implements>

type elementAssembleData = {
  elementName: elementName,
  elementVersion: elementVersion,
  inspectorData: inspectorData,
}

type getElementAssembleData = (
  . account,
  elementName,
  elementVersion,
) => Meta3dBsMost.Most.stream<Js.Nullable.t<elementAssembleData>>

type entryExtensionProtocolName = protocolName

type entryExtensionProtocolVersion = protocolVersion

type entryExtensionProtocolVersionRange = versionRange

type entryExtensionProtocolIconBase64 = protocolIconBase64

type entryExtensionProtocolDisplayName = protocolDisplayName

type entryExtensionProtocolRepoLink = repoLink

type entryExtensionProtocolDescription = description

type entryExtensionName = string

type publishPackage = (
  . onUploadProgressFunc,
  Js.Typed_array.ArrayBuffer.t,
  (
    entryExtensionProtocolName,
    entryExtensionProtocolVersion,
    entryExtensionProtocolVersionRange,
    entryExtensionProtocolIconBase64,
    entryExtensionProtocolDisplayName,
    entryExtensionProtocolRepoLink,
    entryExtensionProtocolDescription,
    entryExtensionName,
  ),
  (implementName, implementVersion, description),
  account,
) => Meta3dBsMost.Most.stream<unit>

type getAllPublishPackageEntryExtensionProtocols = getAllPublishExtensionProtocols

// type packageProtocol = {
//   version: Meta3d.ExtensionFileType.versionRange,
//   name: string,
//   iconBase64: string,
// }

type packageImplementInfo = {
  id: string,
  entryExtensionProtocolName: entryExtensionProtocolName,
  entryExtensionProtocolVersion: entryExtensionProtocolVersion,
  entryExtensionProtocolVersionRange: entryExtensionProtocolVersionRange,
  entryExtensionProtocolIconBase64: entryExtensionProtocolIconBase64,
  entryExtensionName: entryExtensionName,
  name: implementName,
  version: implementVersion,
  account: account,
  description: description,
}

type packageImplementInfos = array<packageImplementInfo>

type getAllPublishPackageInfos = (
  . limitCount,
  skipCount,
  protocolName,
  protocolVersion,
) => Meta3dBsMost.Most.stream<packageImplementInfos>

type findPublishPackage = findPublishExtension

type findNewestPublishPackage = (
  . onDownloadProgressFunc,
  entryExtensionProtocolName,
  implementName,
) => Meta3dBsMost.Most.stream<(
  Js.Typed_array.ArrayBuffer.t,
  entryExtensionProtocolVersion,
  implementVersion,
  entryExtensionProtocolIconBase64,
)>

type findNewestPublishExtension = (
  . onDownloadProgressFunc,
  implementName,
  protocolName,
) => Meta3dBsMost.Most.stream<(
  (
    description,
    implementDisplayName,
    repoLink,
    implementVersion,
    Js.Typed_array.ArrayBuffer.t,
    account,
  ),
  (protocolVersion, protocolIconBase64, protocolDisplayName, protocolRepoLink, protocolDescription),
  Js.Nullable.t<CommonType.protocolConfig>,
)>

type findNewestPublishContribute = findNewestPublishExtension
