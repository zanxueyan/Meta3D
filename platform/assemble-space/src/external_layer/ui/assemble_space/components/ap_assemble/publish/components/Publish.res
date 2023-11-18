open FrontendUtils.Antd
%%raw("import 'antd/dist/antd.css'")
open FrontendUtils.AssembleSpaceType

module Method = {
  let _isSelectedNothing = (selectedPackages, selectedContributes) => {
    selectedPackages->Meta3dCommonlib.ArraySt.length == 0 &&
      selectedContributes->Meta3dCommonlib.ListSt.length == 0
  }

  let getStartPackageNeedConfigData = (
    service,
    selectedPackages: FrontendUtils.ApAssembleStoreType.selectedPackages,
  ) => {
    switch selectedPackages->Meta3dCommonlib.ListSt.find(({isStart}) => {
      isStart
    }) {
    | None => Meta3dCommonlib.Result.fail({j`找不到启动包`})
    | Some({protocolConfigStr}) =>
      switch protocolConfigStr {
      | None => Meta3dCommonlib.Result.fail({j`启动包应该有protocolConfigStr`})
      | Some(protocolConfigStr) =>
        service.meta3d.getNeedConfigData(.
          service.meta3d.serializeStartPackageProtocolConfigLib(. protocolConfigStr),
        )->Meta3dCommonlib.Result.succeed
      }
    }
  }

  let _buildConfigData = (
    values,
    startPackageNeedConfigData: Meta3dType.StartPackageProtocolConfigType.needConfigData,
    apInspectorData: FrontendUtils.ApAssembleStoreType.apInspectorData,
  ) => {
    startPackageNeedConfigData->Meta3dCommonlib.ArraySt.reduceOneParam((. map, {name, type_}) => {
      let value = (values->Obj.magic)[j`configData_${name}`->Obj.magic]

      map->Meta3dCommonlib.ImmutableHashMap.set(
        name,
        switch type_ {
        | #bool => BoolUtils.stringToBool(value)
        | #int => IntUtils.stringToInt(value)->Obj.magic
        | #string => value->Obj.magic
        },
      )
    }, Meta3dCommonlib.ImmutableHashMap.createEmpty()
    ->Meta3dCommonlib.ImmutableHashMap.set("isDebug", apInspectorData.isDebug->Obj.magic)
    ->Meta3dCommonlib.ImmutableHashMap.set("clearColor", apInspectorData.clearColor->Obj.magic)
    ->Meta3dCommonlib.ImmutableHashMap.set(
      "skinName",
      apInspectorData.skinName->Meta3dCommonlib.OptionSt.toNullable->Obj.magic,
    ))
  }

  let _buildSelectedElements = (selectedUIControls, selectedUIControlInspectorData) => {
    let rec _buildUIControls = (selectedUIControls, selectedUIControlInspectorData) => {
      selectedUIControls
      ->Meta3dCommonlib.ListSt.mapi((
        index,
        {id, displayName, children}: FrontendUtils.ElementAssembleStoreType.uiControl,
      ) => {
        let uiControlInspectorData: FrontendUtils.ElementAssembleStoreType.uiControlInspectorData =
          selectedUIControlInspectorData
          ->Meta3dCommonlib.ListSt.nth(index)
          ->Meta3dCommonlib.OptionSt.getExn

        (
          {
            displayName,
            rect: uiControlInspectorData.rect,
            isDraw: uiControlInspectorData.isDraw,
            input: uiControlInspectorData.input->Meta3dCommonlib.OptionSt.toNullable,
            event: uiControlInspectorData.event,
            specific: uiControlInspectorData.specific,
            children: _buildUIControls(children, uiControlInspectorData.children),
          }: FrontendUtils.BackendCloudbaseType.uiControl
        )
      })
      ->Meta3dCommonlib.ListSt.toArray
    }

    list{
      (
        {
          elementName: ElementContributeUtils.getElementContributeName(),
          elementVersion: ElementVisualUtils.getElementContributeVersion(),
          inspectorData: {
            uiControls: _buildUIControls(selectedUIControls, selectedUIControlInspectorData),
          },
        }: FrontendUtils.BackendCloudbaseType.elementAssembleData
      ),
    }
  }

  let _addGeneratedElementContribute = (
    service,
    selectedContributes,
    account,
    selectedUIControls,
    selectedUIControlInspectorData,
  ) => {
    selectedContributes->Meta3dCommonlib.ListSt.push(
      ElementVisualUtils.generateElementContribute(
        service,
        account,
        ElementContributeUtils.buildElementContributeFileStr(
          service,
          selectedUIControls,
          selectedUIControlInspectorData,
        ),
      ),
    )
  }

  let onFinish = (
    service,
    (setUploadProgress, setIsUploadBegin, setVisible),
    (
      account,
      selectedPackages,
      selectedContributes,
      canvasData: FrontendUtils.ElementAssembleStoreType.canvasData,
      apInspectorData,
      storedPackageIdsInApp,
      isChangeSelectedPackagesByDebug,
      selectedUIControls,
      selectedUIControlInspectorData,
    ),
    values,
  ): Js.Promise.t<unit> => {
    let appName = values["appName"]
    let appDescription = values["appDescription"]

    let account = account->Meta3dCommonlib.OptionSt.getExn

    let selectedElements = _buildSelectedElements(
      selectedUIControls,
      selectedUIControlInspectorData,
    )

    let (selectedPackages, allPackagesStoredInApp) = AppUtils.splitPackages(
      selectedPackages,
      storedPackageIdsInApp,
    )
    _isSelectedNothing(selectedPackages, selectedContributes)
      ? {
          service.console.error(. {j`请至少选择一个`}, None)

          ()->Js.Promise.resolve
        }
      : isChangeSelectedPackagesByDebug
      ? {
        service.console.error(.
          {j`Debug时修改了selectedPackages数据，请将对应的包更新为最新版本`},
          None,
        )

        ()->Js.Promise.resolve
      }
      : {
          let selectedContributes =
            selectedContributes
            ->_addGeneratedElementContribute(
              service,
              _,
              account,
              selectedUIControls,
              selectedUIControlInspectorData,
            )
            ->Meta3dCommonlib.ListSt.toArray

          getStartPackageNeedConfigData(
            service,
            selectedPackages->Meta3dCommonlib.ListSt.fromArray,
          )->Meta3dCommonlib.Result.either(
            startPackageNeedConfigData => {
              let appBinaryFile = AppUtils.generateApp(
                service,
                (selectedPackages, allPackagesStoredInApp),
                selectedContributes,
                selectedElements,
                (
                  (
                    {
                      width: canvasData.width,
                      height: canvasData.height,
                    }: Meta3dType.Index.canvasData
                  ),
                  _buildConfigData(values, startPackageNeedConfigData, apInspectorData)->Obj.magic,
                )->Meta3dCommonlib.NullableSt.return,
              )

              setIsUploadBegin(_ => true)

              service.backend.publishApp(.
                progress => setUploadProgress(_ => progress),
                appBinaryFile,
                appName,
                account,
                appDescription,
              )
              ->Meta3dBsMostDefault.Most.drain
              ->Js.Promise.then_(_ => {
                setIsUploadBegin(_ => false)
                setVisible(_ => false)

                ()->Js.Promise.resolve
              }, _)
              ->Js.Promise.catch(e => {
                setIsUploadBegin(_ => false)
                service.console.errorWithExn(.
                  e->FrontendUtils.Error.promiseErrorToExn,
                  None,
                )->Obj.magic
              }, _)
            },
            failMessage => {
              service.console.error(. failMessage, None)

              ()->Js.Promise.resolve
            },
          )
        }
  }

  // let onFinishFailed = (service, errorInfo) => {
  //   ()
  // }

  let useSelector = (
    {apAssembleState, elementAssembleState}: FrontendUtils.AssembleSpaceStoreType.state,
  ) => {
    let {
      selectedPackages,
      selectedContributes,
      apInspectorData,
      isPassDependencyGraphCheck,
      storedPackageIdsInApp,
      isChangeSelectedPackagesByDebug,
    } = apAssembleState
    let {canvasData, selectedUIControls, selectedUIControlInspectorData} = elementAssembleState

    (
      (
        selectedPackages,
        selectedContributes,
        apInspectorData,
        isPassDependencyGraphCheck,
        storedPackageIdsInApp,
        isChangeSelectedPackagesByDebug,
        selectedUIControls,
        selectedUIControlInspectorData,
      ),
      canvasData,
    )
  }
}

@react.component
let make = (~service: service, ~account: option<string>) => {
  let (
    (
      selectedPackages,
      selectedContributes,
      apInspectorData,
      isPassDependencyGraphCheck,
      storedPackageIdsInApp,
      isChangeSelectedPackagesByDebug,
      selectedUIControls,
      selectedUIControlInspectorData,
    ),
    canvasData,
  ) = service.react.useSelector(. Method.useSelector)

  let (visible, setVisible) = service.react.useState(_ => false)

  let (uploadProgress, setUploadProgress) = service.react.useState(_ => 0)
  let (isUploadBegin, setIsUploadBegin) = service.react.useState(_ => false)

  <>
    <Button
      onClick={_ => {
        setVisible(_ => true)
      }}>
      {React.string(`发布`)}
    </Button>
    {visible
      ? <Modal
          title={`发布应用`}
          visible={visible}
          onOk={() => {
            setVisible(_ => false)
          }}
          onCancel={() => {
            setVisible(_ => false)
          }}
          footer={React.null}>
          {isUploadBegin
            ? <p> {React.string({j`${uploadProgress->Js.Int.toString}% uploading...`})} </p>
            : <Form
                labelCol={{
                  "span": 8,
                }}
                wrapperCol={{
                  "span": 6,
                }}
                initialValues={{
                  "remember": true,
                }}
                onFinish={event => FrontendUtils.ErrorUtils.showCatchedErrorMessage(() => {
                    !isPassDependencyGraphCheck
                      ? FrontendUtils.ErrorUtils.error({j`请通过DependencyGraph检查`}, None)
                      : Method.onFinish(
                          service,
                          (setUploadProgress, setIsUploadBegin, setVisible),
                          (
                            account,
                            selectedPackages,
                            selectedContributes,
                            canvasData,
                            apInspectorData,
                            storedPackageIdsInApp,
                            isChangeSelectedPackagesByDebug,
                            selectedUIControls,
                            selectedUIControlInspectorData,
                          ),
                          event->Obj.magic,
                        )->ignore
                  }, 5->Some)}
                // onFinishFailed={Method.onFinishFailed(service)}
                autoComplete="off">
                <Form.Item
                  label={`应用名`}
                  name="appName"
                  rules={[
                    {
                      required: true,
                      message: `输入应用名`,
                    },
                  ]}>
                  <Input />
                </Form.Item>
                <Form.Item
                  label={`介绍`}
                  name="appDescription"
                  rules={[
                    {
                      required: true,
                      message: `输入介绍`,
                    },
                  ]}>
                  <Input />
                </Form.Item>
                <h1> {React.string(`Config Data`)} </h1>
                {Method.getStartPackageNeedConfigData(
                  service,
                  selectedPackages,
                )->Meta3dCommonlib.Result.either(
                  startPackageNeedConfigData => {
                    startPackageNeedConfigData
                    ->Meta3dCommonlib.ArraySt.map((
                      item: Meta3dType.StartPackageProtocolConfigType.configData,
                    ) => {
                      <Form.Item label={item.name} name={j`configData_${item.name}`}>
                        {switch item.type_ {
                        | #bool =>
                          <Select>
                            <Select.Option value={`true`}> {React.string(`true`)} </Select.Option>
                            <Select.Option value={`false`}> {React.string(`false`)} </Select.Option>
                          </Select>
                        | #int
                        | #string =>
                          <Input />
                        }}
                      </Form.Item>
                    })
                    ->React.array
                  },
                  failMessage => {
                    React.null
                  },
                )}
                <Form.Item
                  wrapperCol={{
                    "offset": 8,
                    "span": 16,
                  }}>
                  <Button htmlType="submit"> {React.string(`发布`)} </Button>
                </Form.Item>
              </Form>}
        </Modal>
      : React.null}
  </>
}
