sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'v2.listreport.objectpage.v2listreportobjectpage',
            componentId: 'RootEntitiesList',
            contextPath: '/RootEntities'
        },
        CustomPageDefinitions
    );
});