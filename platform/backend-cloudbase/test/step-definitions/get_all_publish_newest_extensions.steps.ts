import { loadFeature, defineFeature } from "jest-cucumber"
import { createSandbox } from "sinon";
import { resolve } from "meta3d-tool-utils/src/publish/PromiseTool"
import { getAllPublishNewestData } from "../../src/application_layer/assemble_space/element_assemble/GetElementDataService"
import { just } from "most";

const feature = loadFeature("./test/features/get_all_publish_newest_extensions.feature")

defineFeature(feature, test => {
    let sandbox = null
    let getCollectionFunc, getFileFunc

    function _createFuncs(sandbox) {
        getCollectionFunc = sandbox.stub()
        getFileFunc = sandbox.stub()
    }

    function _getAllPublishNewestExtensions(protocolName) {
        return getAllPublishNewestData(
            [getCollectionFunc, getFileFunc],
            "publishedExtensions",
            protocolName
        )
    }

    function _prepare(given) {
        given('prepare sandbox', () => {
            sandbox = createSandbox()
        });
    }

    // test('one extension implement one protocol', ({ given, when, then, and }) => {
    //     let username = "meta3d"
    //     let fileID1 = "id1"
    //     let fileID2 = "id2"
    //     let fileID3 = "id3"
    //     let fileVersion1 = "0.1.1"
    //     let fileVersion2 = "0.1.2"
    //     let fileVersion3 = "0.1.3"
    //     let file1 = new ArrayBuffer(10)
    //     let allPublishExtensions = null

    //     _prepare(given)

    //     given('prepare funcs', () => {
    //         _createFuncs(sandbox)

    //         getCollectionFunc.returns(
    //             resolve({
    //                 data: [
    //                     {
    //                         username: username,
    //                         fileData: [
    //                             {
    //                                 protocolName: "test1-protocol",
    //                                 protocolVersion: "^0.2.0",
    //                                 fileID: fileID1,
    //                                 version: fileVersion1
    //                             },
    //                             {
    //                                 protocolName: "test1-protocol",
    //                                 protocolVersion: "^0.1.0",
    //                                 fileID: fileID2,
    //                                 version: fileVersion2
    //                             },
    //                             {
    //                                 protocolName: "test2-protocol",
    //                                 protocolVersion: "^0.1.0",
    //                                 fileID: fileID3,
    //                                 version: fileVersion3
    //                             }
    //                         ]
    //                     }
    //                 ]
    //             })
    //         )
    //         getFileFunc.returns(
    //             just(file1)
    //         )
    //     });

    //     and('publish extension1', () => {
    //     });

    //     and('publish extension2', () => {
    //     });

    //     when('get all publish extensions', () => {
    //         return _getAllPublishNewestExtensions(
    //             "test1-protocol", "0.1.0"
    //         ).observe(result => {
    //             allPublishExtensions = result
    //         })
    //     });

    //     then('should return correct data', () => {
    //         expect(getFileFunc).toCalledOnce()
    //         expect(getFileFunc).toCalledWith([
    //             fileID2
    //         ])
    //         expect(
    //             allPublishExtensions
    //         ).toEqual([
    //             {
    //                 id: fileID2,
    //                 file: file1,
    //                 version: fileVersion2,
    //                 username
    //             }
    //         ])
    //     });
    // });

    test('two protocols with two versions and implement by two user', ({ given, when, then, and }) => {
        let username1 = "u1"
        let username2 = "u2"
        let protocol1Name = "p1"
        let protocol2Name = "p2"
        let lowVersion = "^0.1.0"
        let highVersion = "^0.2.0"
        let fileID1 = "id1"
        let fileVersion1 = "0.1.1"
        let fileID2 = "id2"
        let fileVersion2 = "0.1.2"
        let fileID3 = "id3"
        let fileVersion3 = "0.1.3"
        let fileID4 = "id4"
        let fileVersion4 = "0.1.4"
        let fileID5 = "id5"
        let fileVersion5 = "0.1.5"
        let file = new ArrayBuffer(10)
        let allPublishExtensions = null

        _prepare(given)

        given('prepare funcs', () => {
            _createFuncs(sandbox)

            getCollectionFunc.returns(
                resolve({
                    data: [
                        {
                            username: username1,
                            fileData: [
                                {
                                    protocolName: protocol1Name,
                                    protocolVersion: lowVersion,
                                    fileID: fileID1,
                                    version: fileVersion1
                                },
                                {
                                    protocolName: protocol2Name,
                                    protocolVersion: lowVersion,
                                    fileID: fileID2,
                                    version: fileVersion2
                                },
                                {
                                    protocolName: protocol1Name,
                                    protocolVersion: highVersion,
                                    fileID: fileID3,
                                    version: fileVersion3
                                },
                            ]
                        },
                        {
                            username: username2,
                            fileData: [
                                {
                                    protocolName: protocol1Name,
                                    protocolVersion: highVersion,
                                    fileID: fileID4,
                                    version: fileVersion4
                                },
                                {
                                    protocolName: protocol2Name,
                                    protocolVersion: highVersion,
                                    fileID: fileID5,
                                    version: fileVersion5
                                },
                            ]
                        }

                    ]
                })
            )
            getFileFunc.returns(
                just(file)
            )
        });

        and('user1 publish extension1 for protocol1 and low version', () => {
        });

        and('user1 publish extension2 for protocol2 and low version', () => {
        });

        and('user1 publish extension3 for protocol1 and high version', () => {
        });

        and('user2 publish extension4 for protocol1 and high version', () => {
        });

        and('user2 publish extension5 for protocol2 and high version', () => {
        });

        when('get all publish newest extensions of protocol1', () => {
            return _getAllPublishNewestExtensions(
                protocol1Name
            ).observe(result => {
                allPublishExtensions = result
            })
        });

        then('should return [extension3, extension4]', () => {
            expect(getFileFunc.callCount).toEqual(3)
            expect(
                allPublishExtensions
            ).toEqual([
                {
                    id: fileID3,
                    file: file,
                    version: fileVersion3,
                    username: username1
                },
                {
                    id: fileID4,
                    file: file,
                    version: fileVersion4,
                    username: username2
                },
            ])
        });
    });
})