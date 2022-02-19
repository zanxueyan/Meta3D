type state

type states = Meta3dCommonlibType.ImmutableHashMapType.t<IWorkForJs.pluginName, state>

type config

type insertAction =
  | Before
  | After

type jobOrder = {
  pipelineName: PipelineType.pipelineName,
  insertElementName: PipelineType.elementName,
  insertAction: insertAction,
}

type jobOrders = array<jobOrder>
