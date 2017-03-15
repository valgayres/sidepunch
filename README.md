# Sidepunch kata

The goal of this kata is to build Sidepunch an alternative implementation of Sidekiq, a background jobs processor.

## Context

This app allows the user to define counters, and increment or decrement them. It uses a JSON HTTP api instead of a local database for storing the counters.

Therefore, modifiying the value of a counter can take a little bit of time, so in order to improve the user experience, the http call to update them is done in a background job, using sidekiq.

In order to beter understand how sidekiq works, you are going to reimplement the behavior of sidekiq in a new library call Sidepunch.
YO
