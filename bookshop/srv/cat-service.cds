using {codejam} from '../db/schema';

service CatalogService {
    entity Books   as projection on codejam.Books
        actions {
            action submitOrder(quantity : Integer) returns {
                stock : Integer
            };
        };

    entity Authors as projection on codejam.Authors;

}
