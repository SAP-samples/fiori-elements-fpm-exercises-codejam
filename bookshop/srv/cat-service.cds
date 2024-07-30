using {codejam} from '../db/schema';

service CatalogService {
    entity Books as projection on codejam.Books actions {
            action submitOrder(quantity : Integer) returns {
                stock : Integer
            };
        };
	entity Sales as projection on codejam.Sales;
    entity Authors as projection on codejam.Authors;
}
