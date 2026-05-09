sap.ui.loader.config({
    shim: {
        "sap/ui/qunit/qunit-junit": {
            deps: ["sap/ui/thirdparty/qunit-2"]
        },
        "sap/ui/qunit/qunit-coverage": {
            deps: ["sap/ui/thirdparty/qunit-2"]
        },
        "sap/ui/thirdparty/sinon-qunit": {
            deps: ["sap/ui/thirdparty/qunit-2", "sap/ui/thirdparty/sinon"]
        },
        "sap/ui/qunit/sinon-qunit-bridge": {
            deps: ["sap/ui/thirdparty/qunit-2", "sap/ui/thirdparty/sinon-4"]
        }
    }
});

window.QUnit = Object.assign({}, window.QUnit, { config: { autostart: false } });

sap.ui.require(
  [
    "sap/ui/thirdparty/qunit-2",
    "sap/ui/qunit/qunit-junit",
    "sap/ui/qunit/qunit-coverage",
    "v2/listreport/objectpage/v2listreportobjectpage/test/integration/FirstJourney",
    "v2/listreport/objectpage/v2listreportobjectpage/test/integration/RootEntitiesListJourney",
    "v2/listreport/objectpage/v2listreportobjectpage/test/integration/RootEntitiesObjectPageJourney",
    "v2/listreport/objectpage/v2listreportobjectpage/test/integration/ChildEntities1ObjectPageJourney",
], function (QUnit) {
    "use strict";
    QUnit.start();
});
