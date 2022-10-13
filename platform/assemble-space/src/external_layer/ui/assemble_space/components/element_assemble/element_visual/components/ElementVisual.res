open FrontendUtils.Antd
%%raw("import 'antd/dist/antd.css'")
open FrontendUtils.AssembleSpaceType

type elementAssembleData =
  | No
  | Loading
  | Loaded(FrontendUtils.BackendCloudbaseType.elementAssembleData)

module Method = {
  let _getVisualExtensionName = () => "meta3d-element-assemble-visual"

  let _getVisualExtensionProtocolName = () => "meta3d-element-assemble-visual-protocol"

  let getAndSetNewestVisualExtension = (service, dispatch, isDebug) => {
    ElementVisualUtils.getAndSetNewestVisualExtension(
      service,
      dispatch,
      extension => FrontendUtils.ElementAssembleStoreType.SetVisualExtension(extension),
      (_getVisualExtensionProtocolName(), _getVisualExtensionName()),
      isDebug,
    )
  }

  let _initApp = (meta3dState, service, initData) => {
    service.meta3d.initExtension(. meta3dState, _getVisualExtensionName(), initData)
  }

  let _updateApp = (meta3dState, service, updateData) => {
    service.meta3d.updateExtension(. meta3dState, _getVisualExtensionName(), updateData)
  }

  let _initAndUpdateApp = (meta3dState, service, initData) => {
    Meta3dBsMost.Most.fromPromise(
      _initApp(meta3dState, service, initData),
    )->Meta3dBsMost.Most.flatMap(meta3dState => {
      meta3dState->_updateApp(service, Obj.magic(1))->Meta3dBsMost.Most.fromPromise
    }, _)
  }

  let _buildApp = (
    service,
    (selectedExtensions, selectedContributes),
    (visualExtension, elementContribute),
  ) => {
    service.meta3d.loadApp(.
      ElementVisualUtils.generateApp(
        service,
        (selectedExtensions, selectedContributes),
        (visualExtension, elementContribute),
      ),
    )->Meta3dCommonlib.Tuple2.getFirst
  }

  let renderApp = (
    service,
    (selectedExtensions, selectedContributes),
    initData,
    (visualExtension, elementContribute),
  ) => {
    _buildApp(
      service,
      (
        selectedExtensions->Meta3dCommonlib.ListSt.toArray,
        selectedContributes->Meta3dCommonlib.ListSt.toArray,
      ),
      (visualExtension, elementContribute),
    )
    ->_initAndUpdateApp(service, initData)
    ->Meta3dBsMost.Most.drain
    ->Js.Promise.catch(e => {
      service.console.error(.
        e->Obj.magic->Js.Exn.message->Meta3dCommonlib.OptionSt.getExn->Obj.magic,
        None,
      )->Obj.magic
    }, _)
  }

  let getInitData = (service: FrontendUtils.AssembleSpaceType.service) => {
    {
      "isDebug": true,
      "canvas": service.dom.querySelector("#ui-visual-canvas")->Meta3dCommonlib.OptionSt.getExn,
    }->Obj.magic
  }

  let isLoaded = (visualExtension, elementAssembleData) => {
    visualExtension->Meta3dCommonlib.OptionSt.isSome &&
      switch elementAssembleData {
      | Loading => false
      | _ => true
      }
  }

  let _getElementContributeName = () => "meta3d-element-assemble-element"

  let _getElementContributeVersion = () => "0.5.0"

  let _getElementContributeProtocolName = () => "meta3d-element-assemble-element-protocol"

  let _getElementContributeProtocolVersion = () => "0.5.1"

  let buildElementContributeFileStr = (
    service,
    selectedUIControls,
    selectedUIControlInspectorData,
    (elementStateFields, reducers),
  ) => {
    ElementMRUtils.buildElementMR(
      service,
      selectedUIControls->Meta3dCommonlib.ListSt.toArray,
      selectedUIControlInspectorData->Meta3dCommonlib.ListSt.toArray,
      (elementStateFields, reducers),
    )->ElementMRUtils.generateElementContributeFileStr(service, _)
  }

  let _buildContribute = (name, version, data): FrontendUtils.ApAssembleStoreType.contribute => {
    id: "",
    version: // version: _getElementContributeVersion(),
    version,
    protocolIconBase64: "",
    protocolConfigStr: None,
    newName: name->Some,
    data: data,
  }

  let _generateElementContribute = (
    service,
    protocolName,
    protocolVersion,
    elementName,
    elementVersion,
    fileStr,
  ) => {
    ElementVisualUtils.generateElementContributeBinaryFile(
      service,
      elementName,
      protocolName,
      protocolVersion,
      fileStr,
    )
    ->service.meta3d.loadContribute(. _)
    ->_buildContribute(elementName, elementVersion, _)
  }

  let generateElementContributeData = (service, fileStr) => {
    let protocolName = _getElementContributeProtocolName()
    let protocolVersion = _getElementContributeProtocolVersion()

    (
      (protocolName, protocolVersion, fileStr),
      _generateElementContribute(
        service,
        protocolName,
        protocolVersion,
        _getElementContributeName(),
        _getElementContributeVersion(),
        fileStr,
      ),
    )
  }

  let updateElementContribute = (dispatch, elementContributeData) => {
    dispatch(FrontendUtils.ElementAssembleStoreType.SetElementContributeData(elementContributeData))
  }

  let getAndSetElementAssembleData = (
    service,
    setElementAssembleData,
    selectedContributes,
    username,
  ) => {
    switch selectedContributes->SelectedContributesUtils.getElements {
    | elements if elements->Meta3dCommonlib.ListSt.length > 1 =>
      service.console.error(. {j`should only select 1 element at most`}, None)

      Js.Promise.resolve()
    | elements if elements->Meta3dCommonlib.ListSt.length === 0 =>
      setElementAssembleData(_ => No)

      Js.Promise.resolve()
    | list{element} =>
      let {version, newName, data} = element

      service.backend.getElementAssembleData(.
        username->Meta3dCommonlib.OptionSt.getExn,
        NewNameUtils.getName(newName, data.contributePackageData.name),
        version,
      )
      ->Meta3dBsMost.Most.tap(elementAssembleData => {
        setElementAssembleData(_ => Loaded(elementAssembleData))
      }, _)
      ->Meta3dBsMost.Most.drain
      ->Js.Promise.catch(e => {
        service.console.error(.
          e->Obj.magic->Js.Exn.message->Meta3dCommonlib.OptionSt.getExn->Obj.magic,
          None,
        )->Obj.magic
      }, _)
    }
  }

  let _generateSelectedUIControls = (selectedContributes, uiControls) => {
    let selectedUIControls =
      selectedContributes->SelectedContributesUtils.getUIControls->Meta3dCommonlib.ListSt.toArray

    uiControls
    ->Meta3dCommonlib.ArraySt.map(({name}: FrontendUtils.BackendCloudbaseType.uiControl) => {
      switch selectedUIControls->Meta3dCommonlib.ArraySt.find(selectedUIControl =>
        NewNameUtils.getName(
          selectedUIControl.newName,
          selectedUIControl.data.contributePackageData.name,
        ) === name
      ) {
      | None =>
        Meta3dCommonlib.Exception.throwErr(
          Meta3dCommonlib.Exception.buildErr(
            Meta3dCommonlib.Log.buildErrorMessage(
              ~title={j`${name} not select`},
              ~description={
                ""
              },
              ~reason="",
              ~solution=j``,
              ~params=j``,
            ),
          ),
        )
      | Some({protocolIconBase64, protocolConfigStr, newName, data}) =>
        (
          {
            id: IdUtils.generateId(Js.Math.random),
            protocolIconBase64: protocolIconBase64,
            protocolConfigStr: protocolConfigStr->Meta3dCommonlib.OptionSt.getExn,
            name: NewNameUtils.getName(newName, data.contributePackageData.name),
            data: data,
          }: FrontendUtils.ElementAssembleStoreType.uiControl
        )
      }
    })
    ->Meta3dCommonlib.ListSt.fromArray
  }

  let _generateSelectedUIControlInspectorData = uiControls => {
    uiControls
    ->Meta3dCommonlib.ArraySt.map((
      {rect, event}: FrontendUtils.BackendCloudbaseType.uiControl,
    ): FrontendUtils.ElementAssembleStoreType.uiControlInspectorData => {
      id: IdUtils.generateId(Js.Math.random),
      rect: rect,
      event: event,
    })
    ->Meta3dCommonlib.ListSt.fromArray
  }

  let importElement = (dispatch, elementAssembleData, selectedContributes) => {
    switch elementAssembleData {
    | Loaded(elementAssembleData) =>
      let {elementName, elementVersion, inspectorData} = elementAssembleData
      let {element, uiControls} = inspectorData

      dispatch(
        FrontendUtils.ElementAssembleStoreType.Import(
          _generateSelectedUIControls(selectedContributes, uiControls),
          _generateSelectedUIControlInspectorData(uiControls),
          element,
        ),
      )

    | _ => ()
    }
  }

  let useSelector = (
    {isDebug, apAssembleState, elementAssembleState}: FrontendUtils.AssembleSpaceStoreType.state,
  ) => {
    let {canvasData, selectedExtensions, selectedContributes} = apAssembleState
    let {
      selectedUIControls,
      selectedUIControlInspectorData,
      visualExtension,
      elementContributeData,
      elementInspectorData,
    } = elementAssembleState

    // let (_, elementContribute) = elementContributeData

    (
      isDebug,
      (canvasData, selectedExtensions, selectedContributes),
      (
        selectedUIControls,
        selectedUIControlInspectorData,
        visualExtension,
        // elementContribute,
        elementContributeData,
        elementInspectorData,
      ),
    )
  }
}

@react.component
let make = (~service: service, ~username: option<string>) => {
  let dispatch = ReduxUtils.ElementAssemble.useDispatch(service.react.useDispatch)

  let (
    isDebug,
    (canvasData, selectedExtensions, selectedContributes),
    (
      selectedUIControls,
      selectedUIControlInspectorData,
      visualExtension,
      // elementContribute,
      elementContributeData,
      elementInspectorData,
    ),
  ) = service.react.useSelector(Method.useSelector)

  let (elementAssembleData, setElementAssembleData) = service.react.useState(_ => Loading)

  let {elementStateFields, reducers} = elementInspectorData

  service.react.useEffect1(. () => {
    switch visualExtension {
    | Some(_) => ()
    | None => Method.getAndSetNewestVisualExtension(service, dispatch, isDebug)->ignore
    }

    None
  }, [])

  service.react.useEffect1(. () => {
    Method.getAndSetElementAssembleData(
      service,
      setElementAssembleData,
      selectedContributes,
      username,
    )->ignore

    None
  }, [selectedContributes])

  service.react.useEffect1(. () => {
    FrontendUtils.ErrorUtils.showCatchedErrorMessage(() => {
      Method.importElement(dispatch, elementAssembleData, selectedContributes)
    }, 5->Some)

    None
  }, [elementAssembleData])

  service.react.useEffect1(. () => {
    selectedUIControlInspectorData->Meta3dCommonlib.ListSt.length > 0
      ? Method.generateElementContributeData(
          service,
          Method.buildElementContributeFileStr(
            service,
            selectedUIControls,
            selectedUIControlInspectorData,
            (elementStateFields, reducers),
          ),
        )->Method.updateElementContribute(dispatch, _)
      : ()

    None
  }, [
    selectedUIControls,
    selectedUIControlInspectorData->Obj.magic,
    elementInspectorData->Obj.magic,
  ])

  service.react.useEffect1(. () => {
    switch (visualExtension, elementContributeData) {
    | (Some(visualExtension), Some(elementContributeData)) =>
      let (_, elementContribute) = elementContributeData

      FrontendUtils.ErrorUtils.showCatchedErrorMessage(() => {
        Method.renderApp(
          service,
          (selectedExtensions, selectedContributes),
          Method.getInitData(service),
          (visualExtension, elementContribute),
        )->ignore
      }, 5->Some)
    | _ => ()
    }

    None
  }, [elementContributeData])

  !Method.isLoaded(visualExtension, elementAssembleData)
    ? <p> {React.string(`loading...`)} </p>
    : <canvas
        id="ui-visual-canvas"
        style={ReactDOM.Style.make(
          ~borderStyle="solid",
          ~borderColor="red",
          ~borderWidth="2px",
          ~width={j`${canvasData.width->Js.Int.toString}px`},
          ~height={j`${canvasData.height->Js.Int.toString}px`},
          (),
        )}
        width={j`${canvasData.width->Js.Int.toString}px`}
        height={j`${canvasData.height->Js.Int.toString}px`}
      />
}
