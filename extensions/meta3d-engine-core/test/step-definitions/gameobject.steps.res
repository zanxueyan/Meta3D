open Meta3dBsJestCucumber
open Cucumber
open Expect
open Operators

let feature = loadFeature("./test/features/gameobject.feature")

defineFeature(feature, test => {
  let data = ref(Obj.magic(1))

  let _buildGameObjectData = (
    ~createStateFunc=() => Obj.magic(1),
    ~createGameObjectFunc=(. state) => (state, Obj.magic(1)),
    ~getAllGameObjectsFunc=(. state) => [],
    (),
  ): Meta3dEngineCoreProtocol.GameObjectType.gameObjectContribute => {
    createStateFunc: createStateFunc,
    createGameObjectFunc: createGameObjectFunc,
    getAllGameObjectsFunc: getAllGameObjectsFunc,
  }

  let _prepare = (given, \"when", \"and") => {
    given("prepare register", () => {
      CreateState.createState()->StateContainer.setState
    })

    \"when"("set gameObject data", () => {
      data :=
        _buildGameObjectData(
          ~createStateFunc=() => {
            {
              "maxUID": 0,
            }->Obj.magic
          },
          ~createGameObjectFunc=(. state) => {
            let gameObject = JsObjTool.getObjValue(state, "maxUID")

            (
              {
                "maxUID": JsObjTool.getObjValue(state, "maxUID")->succ,
              }->Obj.magic,
              gameObject,
            )
          },
          ~getAllGameObjectsFunc=(. state) => {
            Meta3dCommonlib.ArraySt.range(
              0,
              JsObjTool.getObjValue(state, "maxUID") - 1,
            )->Obj.magic
          },
          (),
        )

      Main.setGameObjectData(data.contents)
    })

    \"and"("create and set the gameObject state", () => {
      Main.createAndSetGameObjectState()
    })
  }

  test(."create a gameObject", ({given, \"when", \"and", then}) => {
    _prepare(given, \"when", \"and")

    then("createGameObject should create a gameObject", () => {
      Main.createGameObject()->expect == 0
    })
  })

  test(."get all gameObjects", ({given, \"when", \"and", then}) => {
    let allGameObjects = []

    _prepare(given, \"when", \"and")

    \"when"("create two gameObjects", () => {
      allGameObjects
      ->Meta3dCommonlib.ArraySt.push(Main.createGameObject())
      ->Meta3dCommonlib.ArraySt.push(Main.createGameObject())
      ->ignore
    })

    then("getAllGameObjects should return them", () => {
      Main.getAllGameObjects()->expect == allGameObjects
    })
  })
})
