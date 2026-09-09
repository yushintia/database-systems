-- Lab 09: reset.sql
-- Database Systems (511783-001)
--
-- This is an EMPTY scaffold, not a finished seed. Lab 9 is the first
-- week you write CREATE TABLE yourself, so there is nothing here to
-- run-and-forget: no tables, no data, just a clean, empty database
-- for you to build the registration schema against.
--
-- This script is idempotent: run it once, or run it ten times in a
-- row, and you always land in the exact same empty state. If your own
-- CREATE TABLE statements go wrong partway through, re-run this file
-- first to start clean, then try again.
--
-- How to run it:
--   MySQL Workbench: File > Open SQL Script... then Execute.
--   mysql client:    mysql -u root -p < reset.sql

DROP DATABASE IF EXISTS registration_db;
CREATE DATABASE registration_db;
USE registration_db;

-- Nothing else in this file, on purpose. Your job in this lab's Guided
-- Exercises is to write every CREATE TABLE statement yourself, in the
-- correct dependency order, directly on top of this empty database.
