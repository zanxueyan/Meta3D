open FrontendUtils.AssembleSpaceType

open Sinon

let build = (
  ~sandbox,
  ~dispatch=createEmptyStub(refJsObjToSandbox(sandbox.contents)),
  ~useSelector=createEmptyStub(refJsObjToSandbox(sandbox.contents)),
  ~error=createEmptyStub(refJsObjToSandbox(sandbox.contents)),
  ~getAllPublishExtensionProtocols=createEmptyStub(refJsObjToSandbox(sandbox.contents))
  ->returns(Meta3dBsMost.Most.just([]), _)
  ->Obj.magic,
  (),
) => {
  useDispatch: () => dispatch,
  useSelector: useSelector->Obj.magic,
  error: error->Obj.magic,
  getAllPublishExtensionProtocols: getAllPublishExtensionProtocols->Obj.magic,
}
