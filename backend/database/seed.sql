\c postgres

DROP DATABASE IF EXISTS infowijs;
CREATE DATABASE infowijs;

\c infowijs

CREATE TABLE IF NOT EXISTS appointment
(
    id          integer generated by default as identity constraint appointment_pk primary key,
    code        uuid default gen_random_uuid(),
    title       varchar(100) not null,
    description varchar(300) not null
);

CREATE TABLE IF NOT EXISTS appointment_date
(
    id             integer generated by default as identity constraint appointment_dates_pk primary key,
    appointment_id integer constraint appointment_dates_appointment_id_fk references appointment deferrable initially deferred not null,
    start          timestamp with time zone,
    "end"          timestamp with time zone
);

CREATE TABLE IF NOT EXISTS appointment_date_attendee
(
    id                  integer generated by default as identity constraint appointment_date_attendee_pk primary key,
    appointment_date_id integer constraint appointment_date_attendee_appointment_date_id_fk references appointment_date deferrable initially deferred not null,
    attendee_email      varchar(200) not null,
    UNIQUE(appointment_date_id, attendee_email)
);

INSERT INTO public.appointment (code, title, description)
VALUES ('ef9eeb02-4aa3-4d69-98d9-02db0619cd1b', 'Ouderavond', 'Altijd leuk');

INSERT INTO public.appointment_date (appointment_id, start, "end") VALUES 
(1, '2025-04-05 18:00:00.000000 +00:00', '2025-04-01 18:15:00.000000 +00:00'),
(1, '2025-04-05 18:15:00.000000 +00:00', '2025-04-01 18:30:00.000000 +00:00')