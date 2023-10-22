type rect = {
  x: float,
  y: float,
  width: float,
  height: float,
}

type time = float

type color = (float, float, float)

type clearColor = (float, float, float, float)

type label = string

type size = (int, int)

type pos = (int, int)

type style = string

type texture = Meta3dWebgl1Protocol.ServiceType.texture

type context = Meta3dWebgl1Protocol.ServiceType.webgl1Context

type imageSrc = string

type imguiImplTexture

// @genType
type service = {
  init: (. StateType.state, bool, bool, Dom.htmlCanvasElement) => Js.Promise.t<StateType.state>,
  render: unit => unit,
  setStyle: (. StateType.state, style) => StateType.state,
  beforeExec: (. StateType.state, time) => StateType.state,
  afterExec: unit => unit,
  clear: (. clearColor) => unit,
  beginWindow: (. label) => unit,
  endWindow: unit => unit,
  beginChild: (. label) => unit,
  endChild: unit => unit,
  setNextWindowRect: (. rect) => unit,
  addFBOTexture: (. Js.Null.t<texture>, rect) => unit,
  getWindowBarHeight: unit => float,
  button: (. label, size) => bool,
  setCursorPos: (. pos) => unit,
  loadImage: (. imageSrc) => Js.Promise.t<imguiImplTexture>,
  asset: (
    . {
      "loadGlbTexture": imguiImplTexture,
      "removeAssetTexture": imguiImplTexture,
      "glbTexture": imguiImplTexture,
    },
    array<(string, string)>,
    label,
    rect,
  ) => (bool, bool, Js.Nullable.t<string>),
  handleDragDropTarget: 'data. (. string) => Js.Nullable.t<'data>,
  getContext: unit => context,
}
