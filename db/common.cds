// Pulls in SAP standard building blocks.
// CodeList: base aspect for dropdown/value-help entities — auto-provides code, name, descr, locale fields.
using {
    User,
    sap,
    managed,
    Country,
    sap.common.CodeList
} from '@sap/cds/common';

// Extends SAP's built-in Currencies entity (which only carries alphabetic codes) with
// three extra fields for full ISO 4217 support. Non-destructive — enriches without replacing.
// Borrowed from the cap-sflight reference app.
extend sap.common.Currencies with {
    // ISO 4217 numeric code (e.g. 978 for EUR)
    numcode  : Integer;
    // decimal places for the currency (e.g. 2 → 1 Dollar = 10^2 Cent)
    exponent : Integer; //> e.g. 2 --> 1 Dollar = 10^2 Cent
    // minor unit label (e.g. "Cent")
    minor    : String; //> e.g. 'Cent'
}

// Composite-key code list: a region is uniquely identified by both code AND country,
// so "BY" under Germany is a different record from "BY" under another country.
// @Common.TextArrangement: #TextFirst renders as "Bavaria (BY)" not "BY (Bavaria)".
// @UI.Hidden on country hides the key from the UI — used only for filtering.
entity sap.common.Regions : CodeList {
    key code    : String(10)  @title: '{i18n>region}'  @Common.Text: name  @Common.TextArrangement: #TextFirst;
    // hidden from UI; used only to scope the region code to its country
    key country : Country     @UI.Hidden;
}

// Adds a back-navigation from any Country to its Regions.
// Enables dependent value help in Fiori Elements: when a user picks a country,
// the region picker filters its list to only that country's regions.
extend sap.common.Countries with {
    regions : Composition of many sap.common.Regions
                  on regions.country = $self;
}

//
// Code Lists
//

// Integer-keyed criticality list that maps directly to Fiori Elements built-in colors:
//   0 = Neutral (grey), 1 = Negative (red), 2 = Critical (yellow), 3 = Positive (green).
// In schema.cds, rootBasis.criticality_code stores this integer and the criticality
// association resolves it here for label and color display.
entity sap.common.Criticality : sap.common.CodeList {
    key code : Integer default 0  @Common.Text: name  @Common.TextArrangement: #TextFirst;
}

// UoM code list extended with a scale field (decimal places per unit, e.g. kg→3, pieces→0).
// @Common.UnitSpecificScale: scale — tells Fiori Elements to dynamically adjust the decimal
//   precision of paired amount fields based on the selected UoM.
// @CodeList.ExternalCode: name — uses the human-readable name (e.g. "Kilogram") as the
//   display code instead of the internal code string.
entity sap.common.UnitOfMeasures : CodeList {
        // Search-Term: #CustomUnitScale
    key code  : String(30)  @Common.Text: descr  @Common.UnitSpecificScale: scale  @CodeList.ExternalCode: name;
        scale : Integer;
};
