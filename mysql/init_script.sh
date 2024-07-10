#!/bin/bash

sleep 15 # waiting for mysql service

mysql -u root -p password < ${INITSQL_PATH}/init.sql
