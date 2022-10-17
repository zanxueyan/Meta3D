var gulp = require("gulp");
var path = require("path");
var publish = require("meta3d-tool-publish-protocol")

gulp.task("publish", function (done) {
    publish.publishExtensionProtocol(
        path.join(__dirname, "package.json"),
        path.join(__dirname, "icon.png")
    ).then(() => {
        done()
    })
});


gulp.task("publishConfig", function (done) {
    publish.publishExtensionProtocolConfig(
        path.join(__dirname, "package.json"),
        path.join(__dirname, "dist/static/js", "main.js")
    ).then(() => {
        done()
    })
});


