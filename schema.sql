create database cheerups;

create table activities(
  id SERIAL PRIMARY KEY,
  name TEXT,
  description TEXT,
  image_url TEXT,
  category_id INTEGER,
  location TEXT,
  date DATE,
  time TIME,
  user_id INTEGER
);

create table categories(
  id SERIAL PRIMARY KEY,
  name TEXT
);

create table users(
  id SERIAL PRIMARY KEY,
  name TEXT,
  email VARCHAR(500),
  password_digest VARCHAR(500),
  image_url TEXT,
  phone_number INTEGER,
  house_number INTEGER,
  street_name TEXT,
  suburb TEXT,
  state TEXT,
  country TEXT
);

create table likes(
  id SERIAL PRIMARY KEY,
  user_id INTEGER,
  activity_id INTEGER,
  quote_id INTEGER,
  image_id INTEGER
);

create table comments(
  id SERIAL PRIMARY KEY,
  content TEXT,
  user_id INTEGER,
  activity_id INTEGER,
  quote_id INTEGER,
  image_id INTEGER,
  created_at DATE
);

create table quotes(
  id SERIAL PRIMARY KEY,
  content TEXT,
  user_id INTEGER,
  created_at DATE
);

create table images(
  id SERIAL PRIMARY KEY,
  url TEXT,
  user_id INTEGER,
  created_at DATE
);

