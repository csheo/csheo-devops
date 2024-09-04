CREATE TABLE tb_order (
    order_key                int AUTO_INCREMENT PRIMARY KEY,
    order_name               varchar(50)        NULL,
    order_status_cc_key      mediumint UNSIGNED NULL,
    pg_payment_method_cc_key mediumint UNSIGNED NULL
);

INSERT INTO template.tb_order (order_key, order_name, order_status_cc_key, pg_payment_method_cc_key) VALUES (1, '주문1', 15, 12);
INSERT INTO template.tb_order (order_key, order_name, order_status_cc_key, pg_payment_method_cc_key) VALUES (2, '주문2', 15, 13);
