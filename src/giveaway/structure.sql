CREATE TYPE language AS ENUM('en', 'it', 'fr', 'de', 'ru', 'fa', 'hi', 'pt', 'fi', 'br');
CREATE TYPE giveaway_type AS ENUM('standard', 'cumulative');

CREATE TABLE "User" (
    chat_id int,
    language language DEFAULT 'en',

    PRIMARY KEY (chat_id)
);

CREATE TABLE Giveaway (
    id SERIAL,
    name VARCHAR(50),
    type giveaway_type,
    hashtag VARCHAR(32),
    description VARCHAR(140),
    max_participants int DEFAULT 0, /* 0 for no limit */
    owner_id int,
    created date,
    last date,

    PRIMARY KEY (id),
    FOREIGN KEY (owner_id) REFERENCES "User" (chat_id)
);

CREATE TABLE Type (
    id SERIAL,
    name VARCHAR(32),

    PRIMARY KEY (id)
);

CREATE TABLE Prize (
    id SERIAL,
    name VARCHAR(50),
    key TEXT,
    value float,
    currency VARCHAR(1) DEFAULT '€',
    giveaway_id int,
    type int,

    PRIMARY KEY (id),
    FOREIGN KEY (giveaway_id) REFERENCES Giveaway (id),
    FOREIGN KEY (type) REFERENCES Type (id)
);

CREATE TABLE Joined (
    chat_id int,
    giveaway_id int,
    invites int DEFAULT 0,

    PRIMARY KEY (chat_id, giveaway_id),
    FOREIGN KEY (chat_id) REFERENCES "User" (chat_id),
    FOREIGN KEY (giveaway_id) REFERENCES Giveaway (id)
);

CREATE TABLE Won (
    chat_id int,
    giveaway_id int,
    id_prize int,

    PRIMARY KEY (chat_id, giveaway_id, id_prize),
    FOREIGN KEY (chat_id) REFERENCES "User" (chat_id),
    FOREIGN KEY (giveaway_id) REFERENCES Giveaway (id),
    FOREIGN KEY (id_prize) REFERENCES Prize (id)
);

INSERT INTO Type (name) VALUES ('Videogames');
INSERT INTO Type (name) VALUES ('Coupon');
INSERT INTO Type (name) VALUES ('Gift card');
INSERT INTO Type (name) VALUES ('Other');
