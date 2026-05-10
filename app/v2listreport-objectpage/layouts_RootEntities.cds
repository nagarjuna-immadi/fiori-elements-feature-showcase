using V2LROPODataService as service from '../../srv/v2-list-report-srv';
annotate service.RootEntities with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : imageUrl,
        },
    ]
);

