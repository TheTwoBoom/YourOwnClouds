var email_buffer = buffer_load(working_directory + "emails.json");
var emails_raw = buffer_read(email_buffer, buffer_string);
buffer_delete(email_buffer);
global.emails = json_parse(emails_raw);

var product_buffer = buffer_load(working_directory + "products.json");
var products_raw = buffer_read(product_buffer, buffer_string);
buffer_delete(product_buffer);
global.products = json_parse(products_raw);