using {
    Currency,
    managed,
    cuid,
    sap
} from '@sap/cds/common';

namespace codejam;

entity Books : managed, cuid {
    title       : localized String(111) @mandatory;
    descr       : localized String(1111);
    author      : Association to one Authors;
    genre       : Association to one Genres;
    stock       : Integer               @mandatory;
    criticality : Integer;
    price       : Decimal               @(Measures.ISOCurrency: currency_code)  @mandatory;
    currency    : Currency;
    image       : LargeBinary           @Core.MediaType: 'image/png';
}

entity Authors : managed {
    key ID           : Integer;
        name         : String(111);
        dateOfBirth  : Date;
        dateOfDeath  : Date;
        placeOfBirth : String;
        placeOfDeath : String;
        books        : Association to many Books
                           on books.author = $self;
}

entity Genres : sap.common.CodeList {
    key ID       : Integer;
        parent   : Association to Genres;
        children : Composition of many Genres
                       on children.parent = $self;
}
