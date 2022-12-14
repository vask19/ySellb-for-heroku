CREATE SEQUENCE IF NOT EXISTS hibernate_sequence START WITH 1 INCREMENT BY 1;

CREATE TABLE avatar
(
    avatar_id          BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    name               VARCHAR(255),
    original_file_name VARCHAR(255),
    size               BIGINT,
    content_type       VARCHAR(255),
    is_preview_image   BOOLEAN                                 NOT NULL,
    bytes              OID,
    user_users_id      INTEGER,
    CONSTRAINT pk_avatar PRIMARY KEY (avatar_id)
);

CREATE TABLE bucket
(
    bucket_id INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    users_id  INTEGER,
    CONSTRAINT pk_bucket PRIMARY KEY (bucket_id)
);

CREATE TABLE buckets_products
(
    bucket_id  INTEGER NOT NULL,
    product_id INTEGER NOT NULL
);

CREATE TABLE chat
(
    chat_id       INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    sender_id     INTEGER,
    recipient_id  INTEGER,
    chat_image_id BIGINT,
    CONSTRAINT pk_chat PRIMARY KEY (chat_id)
);

CREATE TABLE image
(
    image_id           BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    name               VARCHAR(255),
    original_file_name VARCHAR(255),
    size               BIGINT,
    content_type       VARCHAR(255),
    is_preview_image   BOOLEAN                                 NOT NULL,
    bytes              OID,
    product_book_id    INTEGER,
    CONSTRAINT pk_image PRIMARY KEY (image_id)
);

CREATE TABLE message
(
    message_id     INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    date_of_create TIMESTAMP WITHOUT TIME ZONE,
    text           VARCHAR(255),
    chat_id        INTEGER,
    sent           BOOLEAN                                  NOT NULL,
    CONSTRAINT pk_message PRIMARY KEY (message_id)
);

CREATE TABLE product
(
    book_id          INTEGER NOT NULL,
    name             VARCHAR(255),
    description      TEXT,
    type             VARCHAR(255),
    locate           VARCHAR(255),
    price            DOUBLE PRECISION,
    users_id         INTEGER,
    preview_image_id BIGINT,
    date_of_created  TIMESTAMP WITHOUT TIME ZONE,
    deleted          BOOLEAN NOT NULL,
    CONSTRAINT pk_product PRIMARY KEY (book_id)
);

CREATE TABLE users
(
    users_id              INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    first_name            VARCHAR(255),
    second_name           VARCHAR(255),
    email                 VARCHAR(255),
    username              VARCHAR(255),
    password              VARCHAR(255),
    phone_number          VARCHAR(255),
    active                BOOLEAN                                  NOT NULL,
    active_email          BOOLEAN                                  NOT NULL,
    email_activation_code INTEGER                                  NOT NULL,
    avatar_id             BIGINT,
    role                  VARCHAR(255),
    date_of_created       TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT pk_users PRIMARY KEY (users_id)
);

ALTER TABLE avatar
    ADD CONSTRAINT FK_AVATAR_ON_USER_USERS FOREIGN KEY (user_users_id) REFERENCES users (users_id);

ALTER TABLE bucket
    ADD CONSTRAINT FK_BUCKET_ON_USERS FOREIGN KEY (users_id) REFERENCES users (users_id);

ALTER TABLE chat
    ADD CONSTRAINT FK_CHAT_ON_RECIPIENT FOREIGN KEY (recipient_id) REFERENCES users (users_id);

ALTER TABLE chat
    ADD CONSTRAINT FK_CHAT_ON_SENDER FOREIGN KEY (sender_id) REFERENCES users (users_id);

ALTER TABLE image
    ADD CONSTRAINT FK_IMAGE_ON_PRODUCT_BOOK FOREIGN KEY (product_book_id) REFERENCES product (book_id);

ALTER TABLE message
    ADD CONSTRAINT FK_MESSAGE_ON_CHAT FOREIGN KEY (chat_id) REFERENCES chat (chat_id);

ALTER TABLE product
    ADD CONSTRAINT FK_PRODUCT_ON_USERS FOREIGN KEY (users_id) REFERENCES users (users_id);

ALTER TABLE users
    ADD CONSTRAINT FK_USERS_ON_AVATAR FOREIGN KEY (avatar_id) REFERENCES avatar (avatar_id);

ALTER TABLE buckets_products
    ADD CONSTRAINT fk_bucpro_on_bucket FOREIGN KEY (bucket_id) REFERENCES bucket (bucket_id);

ALTER TABLE buckets_products
    ADD CONSTRAINT fk_bucpro_on_product FOREIGN KEY (product_id) REFERENCES product (book_id);
