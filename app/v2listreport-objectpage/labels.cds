using V2LROPODataService as service from '../../srv/v2-list-report-srv';

annotate service.RootEntities with {
    imageUrl @title: '{i18n>image}' @UI.IsImageURL : true;
    stringProperty @title: '{i18n>semanticKeyField}';
    fieldWithPrice @title: '{i18n>fieldWithPrice}'  @(Measures.ISOCurrency: isoCurrency_code);
    fieldWithUoM @title: '{i18n>fieldWithUoM}'    @(Measures.Unit: uom_code);
};