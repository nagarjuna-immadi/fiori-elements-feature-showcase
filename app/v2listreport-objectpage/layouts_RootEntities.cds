using V2LROPODataService as service from '../../srv/v2-list-report-srv';
annotate service.RootEntities with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : imageUrl,
            @UI.Importance : #High,
        },
    ],
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : '{i18n>SVariant1}',
    },
    UI.LineItem #tableView : [
    ],
    UI.SelectionPresentationVariant #tableView1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
            SortOrder : [
                {
                    $Type : 'Common.SortOrderType',
                    Property : fieldWithPrice,
                    Descending : false,
                },
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
                {
                    $Type : 'UI.SelectOptionType',
                    PropertyName : criticality_code,
                    Ranges : [
                        {
                            Sign : #I,
                            Option : #GT,
                            Low : 0,
                        },
                    ],
                },
            ],
        },
        Text : '{i18n>SelectionPresentationVariant}',
    },
    UI.SelectionVariant #table : {
        $Type : 'UI.SelectionVariantType',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : criticality_code,
                Ranges : [
                    {
                        Sign : #I,
                        Option : #BT,
                        Low : 0,
                        High : 2,
                    },
                ],
            },
        ],
        Text : '{i18n>SVariant1}',
    },
);

