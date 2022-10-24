open FrontendUtils.Antd
%%raw("import 'antd/dist/antd.css'")

@react.component
let make = (~service: FrontendUtils.FrontendType.service) => {
  let dispatch = AppStore.useDispatch()
  let {selectedExtensions} = AppStore.useSelector(({userCenterState}: AppStore.state) =>
    userCenterState
  )

  let (isLoaded, setIsLoaded) = React.useState(_ => false)
  let (allPublishExtensionProtocols, setAllPublishExtensionProtocols) = React.useState(_ => [])
  let (
    allPublishExtensionProtocolConfigs,
    setAllPublishExtensionProtocolConfigs,
  ) = React.useState(_ => [])
  let (extensionProtocolItem, setExtensionProtocolItem) = React.useState(_ => None)
  let (allPublishExtensions, setAllPublishExtensions) = React.useState(_ => None)

  let _isSelect = (id, selectedExtensions: UserCenterStore.selectedExtensions) => {
    selectedExtensions->Meta3dCommonlib.ListSt.includesByFunc(((selectedExtension, _)) =>
      id === selectedExtension.id
    )
  }

  RescriptReactRouter.watchUrl(url => {
    switch url.path {
    | list{"ExtensionShop"} =>
      setExtensionProtocolItem(_ => None)
      setAllPublishExtensions(_ => None)
    | _ => ()
    }
  })->ignore

  React.useEffect1(() => {
    service.backend.getAllPublishExtensionProtocols()->Meta3dBsMost.Most.flatMap(protocols => {
      service.backend.getAllPublishExtensionProtocolConfigs()->Meta3dBsMost.Most.map(
        protocolConfigs => {
          (protocols, protocolConfigs)
        },
        _,
      )
    }, _)->Meta3dBsMost.Most.observe(((protocols, protocolConfigs)) => {
      setAllPublishExtensionProtocols(_ => protocols)
      setAllPublishExtensionProtocolConfigs(_ => protocolConfigs)
      setIsLoaded(_ => true)
    }, _)->Js.Promise.catch(e => {
      setIsLoaded(_ => false)

      FrontendUtils.ErrorUtils.error(e->Obj.magic, None)->Obj.magic
    }, _)->ignore

    None
  }, [])

  <>
    <Nav />
    {!isLoaded
      ? <p> {React.string(`loading...`)} </p>
      : {
          switch extensionProtocolItem {
          | Some(item: FrontendUtils.BackendCloudbaseType.protocol) =>
            let (protocolName, protocolVersion) = (item.name, item.version)

            switch allPublishExtensions {
            | Some(allPublishExtensions) =>
              <List
                itemLayout=#horizontal
                dataSource={allPublishExtensions}
                renderItem={(item: UserCenterStore.extension) =>
                  <List.Item>
                    <List.Item.Meta
                      key={item.data.extensionPackageData.name}
                      title={<span> {React.string(item.data.extensionPackageData.name)} </span>}
                      description={React.string(`TODO`)}
                    />
                    <span> {React.string({j`版本号：${item.version}`})} </span>
                    <span> {React.string({j`发布者：${item.account}`})} </span>
                    {_isSelect(item.id, selectedExtensions)
                      ? <Button
                          onClick={_ => {
                            dispatch(
                              AppStore.UserCenterAction(
                                UserCenterStore.NotSelectExtension(item.id),
                              ),
                            )
                          }}>
                          {React.string(`取消选择`)}
                        </Button>
                      : <Button
                          onClick={_ => {
                            dispatch(
                              AppStore.UserCenterAction(
                                UserCenterStore.SelectExtension(
                                  item,
                                  allPublishExtensionProtocolConfigs->Meta3dCommonlib.ArraySt.find((
                                    {name, version}: FrontendUtils.CommonType.protocolConfig,
                                  ) => {
                                    name === protocolName && version === protocolVersion
                                  }),
                                ),
                              ),
                            )
                          }}>
                          {React.string(`选择`)}
                        </Button>}
                  </List.Item>}
              />
            | None =>
              setIsLoaded(_ => false)

              service.backend.getAllPublishExtensions(. item.name, item.version)
              ->Meta3dBsMost.Most.map(data => {
                data->Meta3dCommonlib.ArraySt.map((
                  {id, file, version, account}: FrontendUtils.BackendCloudbaseType.implement,
                ): UserCenterStore.extension => {
                  {
                    id: id,
                    data: Meta3d.Main.loadExtension(file),
                    version: version,
                    account: account,
                  }
                })
              }, _)
              ->Meta3dBsMost.Most.observe(data => {
                setIsLoaded(_ => true)

                setAllPublishExtensions(_ => data->Some)
              }, _)
              ->Js.Promise.catch(e => {
                setIsLoaded(_ => false)

                FrontendUtils.ErrorUtils.error(e->Obj.magic, None)->Obj.magic
              }, _)
              ->ignore

              <> </>
            }
          | None =>
            <List
              itemLayout=#horizontal
              dataSource={allPublishExtensionProtocols}
              renderItem={(item: FrontendUtils.BackendCloudbaseType.protocol) =>
                <List.Item>
                  <List.Item.Meta
                    key={item.name}
                    avatar={<img src={item.iconBase64} />}
                    title={<span
                      onClick={_ => {
                        setExtensionProtocolItem(_ => item->Some)
                      }}>
                      {React.string(item.name)}
                    </span>}
                    description={React.string(`TODO`)}
                  />
                  <span> {React.string({j`版本号：${item.version}`})} </span>
                  <span> {React.string({j`发布者：${item.account}`})} </span>
                </List.Item>}
            />
          }
        }}
  </>
}
