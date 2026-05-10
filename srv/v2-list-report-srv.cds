using {sap.fe.showcase as persistence} from '../db/schema';

@requires: 'authenticated-user'
service V2LROPODataService @(path: '/srv2') {
    entity RootEntities as select from persistence.RootEntities;

    entity ChildEntities1 as projection on persistence.ChildEntities1;
}
