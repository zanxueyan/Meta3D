open Meta3dBsJestCucumber
open Cucumber
open Expect
open Operators

open Sinon

let feature = loadFeature("./test/features/publishElement.feature")

defineFeature(feature, test => {
  let account = ref(Obj.magic(1))
  let elementName = ref(Obj.magic(1))
  let elementVersion = ref(Obj.magic(1))
  // let elementInspectorData = ref(Obj.magic(1))
  let selectedUIControls = ref(Obj.magic(1))
  let selectedUIControlInspectorData = ref(Obj.magic(1))
  let input = ref(Obj.magic(1))
  let event = ref(Obj.magic(1))
  let isDraw = ref(Obj.magic(1))
  let specific = ref(Obj.magic(1))

  let sandbox = ref(Obj.magic(1))

  let _prepare = (given, \"and") => {
    given("prepare", () => {
      sandbox := createSandbox()
      ReactTestTool.prepare()
    })
  }

  test(."show publish button", ({given, \"when", \"and", then}) => {
    _prepare(given, \"and")

    \"when"(
      "render Publish",
      () => {
        ()
      },
    )

    then(
      "should show publish button",
      () => {
        PublishElementTool.buildUI(
          ~sandbox,
          ~service=ServiceTool.build(
            ~sandbox,
            ~useSelector=createEmptyStub(refJsObjToSandbox(sandbox.contents))->returns(
              (list{}, list{}),
              _,
            ),
            (),
          ),
          (),
        )
        ->ReactTestRenderer.create
        ->ReactTestTool.createSnapshotAndMatch
      },
    )
  })

  // test(."show modal after click publish button", ({given, \"when", \"and", then}) => {
  //   _prepare(given, \"and")

  //   \"when"("render Publish", () => {
  //     ()
  //   })

  //   \"and"("click publish button", () => {
  //     ()
  //   })

  //   then("should show modal", () => {
  //     let component =
  //       PublishElementTool.buildUI(
  //         ~sandbox,
  //         ~service=ServiceTool.build(
  //           ~sandbox,
  //           ~useState=createEmptyStub(refJsObjToSandbox(sandbox.contents))->returns(
  //             (true, _ => true),
  //             _,
  //           ),
  //           ~useSelector=createEmptyStub(refJsObjToSandbox(sandbox.contents))->returns(
  //             (
  //               ElementInspectorTool.buildElementInspectorData(list{}, ReducerTool.buildReducers()),
  //               list{},
  //             ),
  //             _,
  //           ),
  //           (),
  //         ),
  //         (),
  //       )
  //       ->ReactTestRenderer.create
  //       ->ReactTestTool.createSnapshotAndMatch
  //   })
  // })

  // test(."publish when has no element contribute data", ({given, \"when", \"and", then}) => {
  //   let errorStub = ref(Obj.magic(1))

  //   _prepare(given, \"and")

  //   CucumberAsync.execStep(\"when", "publish", () => {
  //     errorStub := createEmptyStub(refJsObjToSandbox(sandbox.contents))

  //     PublishElementTool.publish(
  //       ~sandbox,
  //       ~service=ServiceTool.build(~sandbox, ~error=errorStub.contents, ()),
  //       (),
  //     )
  //   })

  //   then("should error", () => {
  //     errorStub.contents
  //     ->Obj.magic
  //     ->SinonTool.calledWithArg2({j`没有找到ElementContribute Data`}, None)
  //     ->expect == true
  //   })
  // })

  let _prepareData = given => {
    given("prepare data", () => {
      account := "u1"
      elementName := "e1"
      elementVersion := "0.1.1"
      // elementInspectorData :=
      //   ElementInspectorTool.buildElementInspectorData(list{})

      input := UIControlInspectorTool.buildInput(~inputName="input", ())
      event := [
          UIControlInspectorTool.buildEventData(~eventName=#button_click, ~actionName="a1", ()),
        ]

      isDraw := false->FrontendUtils.CommonType.BoolForIsDraw

      specific := [UIControlInspectorTool.buildSpecific()]

      selectedUIControls :=
        list{
          SelectedUIControlsTool.buildSelectedUIControl(
            ~id="b1",
            ~displayName="b1",
            ~data=ContributeTool.buildContributeData(
              ~contributePackageData=ContributeTool.buildContributePackageData(
                ~protocol={
                  name: "p1",
                  version: "^0.0.1",
                },
                (),
              ),
              (),
            ),
            ~children=list{
              SelectedUIControlsTool.buildSelectedUIControl(
                ~id="b2",
                ~displayName="b2",
                ~data=ContributeTool.buildContributeData(
                  ~contributePackageData=ContributeTool.buildContributePackageData(
                    ~protocol={
                      name: "p2",
                      version: "^0.0.2",
                    },
                    (),
                  ),
                  (),
                ),
                ~children=list{},
                (),
              ),
            },
            (),
          ),
        }
      selectedUIControlInspectorData :=
        list{
          UIControlInspectorTool.buildUIControlInspectorData(
            ~id="b1",
            ~x=1->FrontendUtils.CommonType.IntForRectField,
            ~input=input.contents->Some,
            ~event=event.contents,
            ~isDraw=isDraw.contents,
            ~specific=specific.contents,
            ~children=list{
              UIControlInspectorTool.buildUIControlInspectorData(
                ~id="b2",
                ~x=2->FrontendUtils.CommonType.IntForRectField,
                ~event=event.contents,
                ~isDraw=isDraw.contents,
                ~specific=specific.contents,
                ~children=list{},
                (),
              ),
            },
            (),
          ),
        }
    })
  }

  // test(."generate element contribute", ({given, \"when", \"and", then}) => {
  //   let generateContributeStub = ref(Obj.magic(1))

  //   _prepare(given, \"and")

  //   _prepareData(given)

  //   CucumberAsync.execStep(
  //     \"when",
  //     "publish",
  //     () => {
  //       generateContributeStub := createEmptyStub(refJsObjToSandbox(sandbox.contents))

  //       PublishElementTool.publish(
  //         ~sandbox,
  //         ~values={
  //           "elementName": elementName.contents,
  //           "elementVersion": elementVersion.contents,
  //         },
  //         ~service=ServiceTool.build(
  //           ~sandbox,
  //           ~generateContribute=generateContributeStub.contents->Obj.magic,
  //           ~serializeUIControlProtocolConfigLib=Meta3d.Main.serializeUIControlProtocolConfigLib->Obj.magic,
  //           ~getUIControlSupportedEventNames=Meta3d.Main.getUIControlSupportedEventNames->Obj.magic,
  //           ~generateHandleUIControlEventStr=Meta3d.Main.generateHandleUIControlEventStr->Obj.magic,
  //           (),
  //         ),
  //         ~account=account.contents->Some,
  //         (),
  //       )
  //     },
  //   )

  //   then(
  //     "should generat element contribute",
  //     () => {
  //       (
  //         generateContributeStub.contents
  //         ->Obj.magic
  //         ->SinonTool.getArg(~stub=_, ~argIndex=1, ())
  //         ->Js.String.includes("elementName:\"e1\",", _),
  //         generateContributeStub.contents
  //         ->Obj.magic
  //         ->SinonTool.calledWith(
  //           (
  //             {
  //               name: elementName.contents,
  //               version: elementVersion.contents,
  //               account: account.contents,
  //               displayName: elementName.contents,
  //               repoLink: ElementContributeUtils.getElementContributeRepoLink(),
  //               description: ElementContributeUtils.getElementContributeDescription(),
  //               protocol: {
  //                 name: ElementContributeUtils.getElementContributeProtocolName(),
  //                 version: FrontendUtils.ElementUtils.getElementContributeProtocolVersion(),
  //               },
  //               dependentPackageStoredInAppProtocolNameMap: Meta3dCommonlib.ImmutableHashMap.createEmpty(),
  //               dependentBlockProtocolNameMap: Meta3dCommonlib.ImmutableHashMap.createEmpty(),
  //               // ->Meta3dCommonlib.ImmutableHashMap.set(
  //               //   "meta3d-ui-protocol",
  //               //   ElementVisualTool.getUIProtocolVersion(),
  //               // )
  //               // ->Meta3dCommonlib.ImmutableHashMap.set(
  //               //   "meta3d-event-protocol",
  //               //   ElementVisualTool.getEventProtocolVersion(),
  //               // ),
  //             }: Meta3d.ExtensionFileType.contributePackageData
  //           ),
  //         ),
  //       )->expect == (true, true)
  //     },
  //   )
  // })

  // test(."publish element contribute", ({given, \"when", \"and", then}) => {
  //   let publishElementContributeStub = ref(Obj.magic(1))
  //   let elementContributeBinaryFile = Js.Typed_array.ArrayBuffer.make(11)
  //   let setIsUploadBeginStub = ref(Obj.magic(1))

  //   _prepare(given, \"and")

  //   _prepareData(given)

  //   CucumberAsync.execStep(
  //     \"when",
  //     "publish",
  //     () => {
  //       setIsUploadBeginStub := createEmptyStub(refJsObjToSandbox(sandbox.contents))

  //       publishElementContributeStub :=
  //         createEmptyStub(refJsObjToSandbox(sandbox.contents))->returns(
  //           Meta3dBsMostDefault.Most.empty(),
  //           _,
  //         )

  //       PublishElementTool.publish(
  //         ~sandbox,
  //         ~account=account.contents->Some,
  //         ~setIsUploadBegin=setIsUploadBeginStub.contents->Obj.magic,
  //         ~values={
  //           "elementName": elementName.contents,
  //           "elementVersion": elementVersion.contents,
  //         },
  //         ~service=ServiceTool.build(
  //           ~sandbox,
  //           ~publishElementContribute=publishElementContributeStub.contents->Obj.magic,
  //           ~generateContribute=createEmptyStub(refJsObjToSandbox(sandbox.contents))
  //           ->returns(elementContributeBinaryFile, _)
  //           ->Obj.magic,
  //           (),
  //         ),
  //         // ~elementInspectorData=elementInspectorData.contents,
  //         // ~selectedUIControls=selectedUIControls.contents,
  //         // ~selectedUIControlInspectorData=selectedUIControlInspectorData.contents,
  //         (),
  //       )
  //     },
  //   )

  //   then(
  //     "should mark begin upload",
  //     () => {
  //       let func = SinonTool.getFirstArg(~callIndex=0, ~stub=setIsUploadBeginStub.contents, ())

  //       (
  //         setIsUploadBeginStub.contents
  //         ->getCall(0, _)
  //         ->calledBefore(publishElementContributeStub.contents->getCall(0, _)),
  //         func(),
  //       )->expect == (true, true)
  //     },
  //   )

  //   \"and"(
  //     "should publish generated element contribute",
  //     () => {
  //       publishElementContributeStub.contents
  //       ->Obj.magic
  //       ->SinonTool.calledWithArg4(
  //         matchAny,
  //         account.contents,
  //         (
  //           elementName.contents,
  //           elementVersion.contents,
  //           ElementContributeUtils.getElementContributeProtocolName(),
  //           FrontendUtils.ElementUtils.getElementContributeProtocolVersion(),
  //           elementName.contents,
  //           ElementContributeUtils.getElementContributeRepoLink(),
  //           ElementContributeUtils.getElementContributeDescription(),
  //         ),
  //         elementContributeBinaryFile,
  //       )
  //       ->expect == true
  //     },
  //   )
  // })

  test(."publish element assemble data", ({given, \"when", \"and", then}) => {
    let findNewestPublishElementAssembleDataStub = ref(Obj.magic(1))
    let publishElementAssembleDataStub = ref(Obj.magic(1))

    _prepare(given, \"and")

    _prepareData(given)

    CucumberAsync.execStep(
      \"when",
      "publish",
      () => {
        findNewestPublishElementAssembleDataStub :=
          createEmptyStub(refJsObjToSandbox(sandbox.contents))
          ->withOneArg(elementName.contents, _)
          ->returns(
            ImportElementTool.buildElementAssembleData(
              ~elementName=elementName.contents,
              ~elementVersion=elementVersion.contents,
              (),
            )
            ->Meta3dCommonlib.NullableSt.return
            ->Meta3dBsMostDefault.Most.just,
            _,
          )

        publishElementAssembleDataStub :=
          createEmptyStub(refJsObjToSandbox(sandbox.contents))->returns(
            Meta3dBsMostDefault.Most.empty(),
            _,
          )

        PublishElementTool.publish(
          ~sandbox,
          ~account=account.contents->Some,
          ~values={
            "elementName": elementName.contents,
          },
          ~service=ServiceTool.build(
            ~sandbox,
            ~findNewestPublishElementAssembleData=findNewestPublishElementAssembleDataStub.contents->Obj.magic,
            ~publishElementAssembleData=publishElementAssembleDataStub.contents->Obj.magic,
            (),
          ),
          ~selectedUIControls=selectedUIControls.contents,
          ~selectedUIControlInspectorData=selectedUIControlInspectorData.contents,
          (),
        )
      },
    )

    then(
      "should find newest element version",
      () => {
        ()
      },
    )

    \"and"(
      "publish element assemble data",
      () => {
        publishElementAssembleDataStub.contents
        ->Obj.magic
        ->SinonTool.calledWithArg4(
          account.contents,
          elementName.contents,
          "0.1.2",
          (
            {
              uiControls: [
                {
                  protocol: {
                    name: "p1",
                    version: "^0.0.1",
                  },
                  displayName: "b1",
                  rect: UIControlInspectorTool.buildRect(
                    ~x=1->FrontendUtils.CommonType.IntForRectField,
                    (),
                  ),
                  isDraw: isDraw.contents,
                  input: input.contents->Some->ImportElementTool.convertInput,
                  event: event.contents->ImportElementTool.convertEvent,
                  specific: specific.contents,
                  children: [
                    {
                      protocol: {
                        name: "p2",
                        version: "^0.0.2",
                      },
                      displayName: "b2",
                      rect: UIControlInspectorTool.buildRect(
                        ~x=2->FrontendUtils.CommonType.IntForRectField,
                        (),
                      ),
                      isDraw: isDraw.contents,
                      input: Meta3dCommonlib.NullableSt.getEmpty(),
                      event: event.contents->ImportElementTool.convertEvent,
                      specific: specific.contents,
                      children: [],
                    },
                  ],
                },
              ],
            }: FrontendUtils.BackendCloudbaseType.inspectorData
          ),
        )
        ->expect == true
      },
    )
  })

  test(."handle after publish successfully", ({given, \"when", \"and", then}) => {
    let setIsUploadBeginStub = ref(Obj.magic(1))
    let setVisibleStub = ref(Obj.magic(1))
    let publishElementAssembleDataStub = ref(Obj.magic(1))

    _prepare(given, \"and")

    _prepareData(given)

    CucumberAsync.execStep(
      \"when",
      "publish",
      () => {
        setIsUploadBeginStub := createEmptyStub(refJsObjToSandbox(sandbox.contents))
        setVisibleStub := createEmptyStub(refJsObjToSandbox(sandbox.contents))
        publishElementAssembleDataStub :=
          createEmptyStub(refJsObjToSandbox(sandbox.contents))->returns(
            Meta3dBsMostDefault.Most.empty(),
            _,
          )

        PublishElementTool.publish(
          ~sandbox,
          ~account=account.contents->Some,
          ~setIsUploadBegin=setIsUploadBeginStub.contents->Obj.magic,
          ~setVisible=setVisibleStub.contents->Obj.magic,
          ~service=ServiceTool.build(
            ~sandbox,
            ~findNewestPublishElementAssembleData=createEmptyStub(
              refJsObjToSandbox(sandbox.contents),
            )
            ->returns(Meta3dCommonlib.NullableSt.getEmpty()->Meta3dBsMostDefault.Most.just, _)
            ->Obj.magic,
            ~publishElementAssembleData=publishElementAssembleDataStub.contents->Obj.magic,
            (),
          ),
          (),
        )
      },
    )

    then(
      "should mark finish upload",
      () => {
        let func = SinonTool.getFirstArg(~callIndex=1, ~stub=setIsUploadBeginStub.contents, ())

        (
          setIsUploadBeginStub.contents
          ->getCall(1, _)
          ->calledAfter(publishElementAssembleDataStub.contents->getCall(0, _)),
          func(),
        )->expect == (true, false)
      },
    )

    \"and"(
      "should close modal",
      () => {
        let func = SinonTool.getFirstArg(~stub=setVisibleStub.contents, ())

        func()->expect == false
      },
    )
  })
})
