var file_buffer = buffer_load(working_directory + "emails.json");
var emails_raw = buffer_read(file_buffer, buffer_string);
buffer_delete(file_buffer);
global.emails = json_parse(emails_raw)