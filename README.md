[TOC]

# Sidepunch kata

The goal of this kata is to build Sidepunch an alternative implementation of Sidekiq, a background jobs processor.

## Context

This app allows the user to define counters, and increment or decrement them. It uses a JSON HTTP api instead of a local database for storing the counters.

Therefore, modifiying the value of a counter can take a little bit of time, so in order to improve the user experience, the http call to update them is done in a background job, using sidekiq.

In order to beter understand how sidekiq works, you are going to reimplement the behavior of sidekiq in a new library call Sidepunch.


## Sidekiq

Sidekiq is one of the main gem to handle background job in ruby. Sidekiq is a multi-threaded program, hence it provides the possibility to execute multiple jobs at the same time.
The main way to use sidekiq is to create a worker:

```
class MyWorker
  include Sidekiq::Worker

  def perform(args)
    #to some things
  end
```

Including the module `Sidekiq::Worker`, the class gets a static method `perform_async` that gets executed in the sidekiq process instead of the process that called the method.

Sidekiq uses Redis to transmit the data from the main process to the process handling the execution of the code.

## What you will have to do

In order to simulate how sidekiq work, you will have to handle several things:

Mandatory
: In the main process, how to save the job to be performed in redis 
: In the background process, how to find the job to be performed

Optional
: Handle retries in the background process
: Create a queue logic
: Multithreading of the background process