open FrontendUtils.Antd
%%raw("import 'antd/dist/antd.css'")

// TODO check login

@react.component
let make = () => {
  let {account} = AppStore.useSelector(({userCenterState}: AppStore.state) => userCenterState)

  let (refreshValue, refresh) = React.useState(_ => Js.Math.random())
  let (isLoaded, setIsLoaded) = React.useState(_ => false)
  let (allPublishApps, setAllPublishApps) = React.useState(_ => [])

  let _buildURL = (account: string, appName: string) =>
    j`EnterApp?account=${account}&appName=${appName}`

  let _openLink = url => {
    FrontendUtils.Window.\"open"(url, "_blank").focus()
  }

  RescriptReactRouter.watchUrl(url => {
    switch url.path {
    | list{"ShowPublishedApps"} =>
      setAllPublishApps(_ => [])
      setIsLoaded(_ => false)
      refresh(_ => Js.Math.random())
    | _ => ()
    }
  })->ignore

  React.useEffect1(() => {
    BackendCloudbase.findAllPublishApps(. account->Meta3dCommonlib.OptionSt.getExn)
    ->Meta3dBsMost.Most.observe(allPublishApps => {
      setAllPublishApps(_ => allPublishApps)
      setIsLoaded(_ => true)
    }, _)
    ->Js.Promise.catch(e => {
      setIsLoaded(_ => false)

      FrontendUtils.ErrorUtils.error(e->Obj.magic, None)->Obj.magic
    }, _)
    ->ignore

    None
  }, [refreshValue])

  <>
    <Nav />
    {!isLoaded
      ? <p> {React.string(`loading...`)} </p>
      : <List
          itemLayout=#horizontal
          dataSource={allPublishApps}
          renderItem={(item: FrontendUtils.BackendCloudbaseType.publishAppData) =>
            <List.Item>
              <List.Item.Meta
                key={j`${item.account}_${item.appName}`}
                title={<span
                  onClick={_ => {
                    _openLink(_buildURL(item.account, item.appName))
                  }}>
                  {React.string(item.appName)}
                </span>}
              />
            </List.Item>}
        />}
  </>
}
