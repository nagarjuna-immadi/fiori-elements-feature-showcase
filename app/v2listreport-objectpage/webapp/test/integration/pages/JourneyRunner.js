sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"v2/listreport/objectpage/v2listreportobjectpage/test/integration/pages/RootEntitiesList",
	"v2/listreport/objectpage/v2listreportobjectpage/test/integration/pages/RootEntitiesObjectPage",
	"v2/listreport/objectpage/v2listreportobjectpage/test/integration/pages/ChildEntities1ObjectPage"
], function (JourneyRunner, RootEntitiesList, RootEntitiesObjectPage, ChildEntities1ObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('v2/listreport/objectpage/v2listreportobjectpage') + '/test/flp.html#app-preview',
        pages: {
			onTheRootEntitiesList: RootEntitiesList,
			onTheRootEntitiesObjectPage: RootEntitiesObjectPage,
			onTheChildEntities1ObjectPage: ChildEntities1ObjectPage
        },
        async: true
    });

    return runner;
});

