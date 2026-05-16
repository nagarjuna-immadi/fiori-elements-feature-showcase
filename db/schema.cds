// cuid: auto-generates a UUID primary key
// managed: adds createdAt, createdBy, modifiedAt, modifiedBy audit fields
// Country, Currency: SAP standard ISO code list types
// CodeList: base aspect for dropdown/value-help entities
using {
                           Country,
    sap.common.CodeList as CodeList,
                           cuid,
                           Currency,
                           managed,
                           sap,
} from '@sap/cds/common';
// Regions, UnitOfMeasures, Criticality: custom code lists defined in common.cds
using {
    sap.common.Regions,
    sap.common.UnitOfMeasures,
    sap.common.Criticality
} from '../db/common.cds';

namespace sap.fe.showcase;

// Reusable aspect (mixin) — not an entity itself.
// Bundles all field types needed to showcase Fiori Elements annotation patterns.
// Mixed into RootEntities via ": rootBasis".
aspect rootBasis : {
    // --- Display ---
    imageUrl                    : String;
    stringProperty              : String;

    // --- Numeric / KPI — used for micro charts and KPI tiles ---
    integerValue                : Integer;
    forecastValue               : Integer;
    targetValue                 : Integer default 30;
    dimensions                  : Integer;

    // --- Rating — drives star-rating display in Fiori Elements ---
    starsValue                  : Decimal;

    // --- Contact card — links to a full contact record ---
    contact                     : Association to one Contacts;

    // --- Criticality — integer code drives color-coding (red/yellow/green) in the UI.
    //     criticality resolves the code to the CodeList for label/color display. ---
    criticality_code            : Integer;
    criticality                 : Association to one Criticality
                                      on criticality.code = criticality_code;

    // --- Unit of Measure — decimal paired with a UoM code list association ---
    fieldWithUoM                : Decimal(15, 3);
    uom                         : Association to one UnitOfMeasures;

    // --- Currency — decimal paired with SAP Currency type (ISO 4217) ---
    fieldWithPrice              : Decimal(12, 3);
    isoCurrency                 : Currency;

    // --- Field whose value itself carries criticality (annotated separately) ---
    fieldWithCriticality        : String;

    // --- Boolean flags — control action visibility (delete/update) in the UI ---
    deletePossible              : Boolean;
    updateHidden                : Boolean;

    // --- URL fields — rendered as clickable links; text is the link label ---
    fieldWithURL                : String;
    fieldWithURLtext            : String;

    // --- Contact info ---
    email                       : String;
    telephone                   : String;

    // --- Location — country (ISO) + two region pickers:
    //     regionWithConstantValueHelp: fixed value help list
    //     region: dynamic value help filtered by country ---
    country                     : Country;
    regionWithConstantValueHelp : Association to one Regions;
    region                      : Association to one Regions;

    // --- Date/Time — showcases all CDS temporal types ---
    validFrom                   : Date; //Search-Term: #TimeAndDate
    validTo                     : DateTime;
    time                        : Time;
    timeStamp                   : Timestamp;

    // --- Long text fields — second variant demos custom growing textarea ---
    description                 : String(1000);
    description_customGrowing   : String(1000);

    // --- Org unit picker — links to the hierarchical OrganizationalUnits tree ---
    organizationalUnit          : Association to one OrganizationalUnits;
};

// Main showcase entity. Inherits all rootBasis fields plus auto UUID (cuid) and
// audit trail (managed). Owns all child data via Composition (cascaded delete).
// association2one to Orders is a non-owning foreign-key reference (not cascaded).
entity RootEntities : cuid, managed, rootBasis {
    childEntities1  : Composition of many ChildEntities1 // owned child rows, sub-object table
                          on childEntities1.parent = $self;
    association2one : Association to one Orders; // referenced, not owned
    childEntities3  : Composition of many ChildEntities3
                          on childEntities3.parent = $self;
    chartEntities   : Composition of many ChartDataEntities // chart demo data per root
                          on chartEntities.parent = $self;
    regions         : Composition of many AssignedRegions // many-to-many bridge to Regions
                          on regions.root = $self;
};

// First-level child of RootEntities. Demonstrates sub-object table with a
// nested grandchild level (three levels deep: Root → Child1 → GrandChild).
entity ChildEntities1 : cuid {
    parent           : Association to one RootEntities;
    field            : String;
    fieldWithPerCent : Decimal(5, 2);
    booleanProperty  : Boolean default false;
    criticalityValue : Association to one Criticality;
    grandChildren    : Composition of many GrandChildEntities
                           on grandChildren.parent = $self;
}

// Third level of the composition hierarchy: Root → ChildEntities1 → GrandChildEntities.
entity GrandChildEntities : cuid {
    parent : Association to one ChildEntities1;
    field  : String;
}

//@cds.odata.valuelist -- enables automatic value list with keys on UI
// Order header — referenced (not owned) by RootEntities via association2one.
// Owns its line items via Composition.
entity Orders : cuid {
    stringProperty  : String;
    integerProperty : Integer;
    decimalProperty : Decimal(5, 3);
    country         : Country;
    items           : Composition of many OrderItems
                          on items.order = $self;
}

// Order line items — owned by Orders.
entity OrderItems : cuid {
    order           : Association to one Orders;
    product         : String;
    productCategory : String;
    netValue        : Decimal(6, 3);
    currency        : Currency;
}

// Standalone delivery entity linked to an Order (not owned by it).
// Tracks delivery date, tracking ID, and its own line items.
entity Deliveries : cuid {
    order          : Association to one Orders;
    stringProperty : String;
    deliveryDate   : Date;
    trackingId     : String;
    items          : Composition of many DeliveryItems
                         on items.delivery = $self;
}

entity DeliveryItems : cuid {
    delivery : Association to one Deliveries;
    product  : String;
}

// Minimal second child type of RootEntities — used to showcase additional sub-object patterns.
entity ChildEntities3 : cuid {
    parent : Association to one RootEntities;
    field  : String;
}

// Chart data rows owned by a RootEntity. Fields map directly to Fiori Elements
// chart annotations (bullet charts, area charts with tolerance/deviation bands).
entity ChartDataEntities : cuid {
    parent                            : Association to one RootEntities;
    criticality                       : Association to one Criticality;
    integerValue                      : Integer;
    integerValueWithUoM               : Integer;
    uom                               : Association to one UnitOfMeasures;
    forecastValue                     : Integer;
    targetValue                       : Integer default 30;
    dimensions                        : Integer;

    // Area chart band boundaries — upper/lower tolerance and deviation thresholds
    areaChartToleranceUpperBoundValue : Integer default 90;
    areaChartToleranceLowerBoundValue : Integer default 80;
    areaChartDeviationUpperBoundValue : Integer default 50;
    areaChartDeviationLowerBoundValue : Integer default 0;
}

// Contact card data — linked from rootBasis.contact.
// Rendered as a QuickView / Contact annotation in Fiori Elements.
entity Contacts : cuid {
    name         : String;
    phone        : String;
    building     : String;
    country      : Country;
    street       : String;
    city         : String;
    postCode     : String;
    addressLabel : String;
    photoUrl     : String;
}

// Many-to-many bridge between RootEntities and Regions.
// A root can be assigned to multiple regions; each row is one assignment.
entity AssignedRegions : cuid {
    root   : Association to one RootEntities;
    region : Association to one Regions;
}

// Self-referencing hierarchy — each unit can have a parent (superOrdinateOrgUnit)
// and exposes its children via subordinaryOrgUnits. Used with tree/hierarchy annotations.
// name and description are localized (translation table generated by CDS).
entity OrganizationalUnits : cuid {
    externalId           : String(128);
    rank                 : Integer default 0; //Sorting order
    name                 : localized String(128);
    description          : localized String(256);
    isActive             : Boolean default true;
    category             : Association to one OrganizationalUnitCategoryCodes;
    superOrdinateOrgUnit : Association to one OrganizationalUnits; // parent node
    subordinaryOrgUnits  : Association to many OrganizationalUnits // child nodes
                               on subordinaryOrgUnits.superOrdinateOrgUnit = $self;

}

// Simple 2-char code list for classifying org units (e.g. "BU", "DV").
entity OrganizationalUnitCategoryCodes : CodeList {
    key code : String(2);
}
