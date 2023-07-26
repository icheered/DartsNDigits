#!/bin/bash
npm install
npm run build
pm2 delete dartsndigits
PORT=4006 pm2 start npm --name "dartsndigits" -- start
