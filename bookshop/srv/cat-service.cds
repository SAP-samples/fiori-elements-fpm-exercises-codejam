using {codejam} from '../db/schema';

service CatalogService {
    entity Books   as projection on codejam.Books;
    entity Authors as projection on codejam.Authors;

    action submitOrder(book : Books:ID, quantity : Integer) returns {
        stock : Integer
    };
}
